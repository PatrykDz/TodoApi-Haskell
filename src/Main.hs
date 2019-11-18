{-# LANGUAGE OverloadedStrings #-}
module Main where

import Control.Monad.IO.Class (liftIO)
import Control.Monad (forM_)
import Data.Text (Text)
import Data.IORef
import Web.Spock
import Web.Spock.Config
import Web.Spock.Lucid (lucid)
import Lucid

data Note = Note {author :: Text, contents :: Text }
newtype ServerState = ServerState { notes :: IORef [Note] }

type Server a = SpockM () () ServerState a

app :: Server ()
app = get root $ do 
    notes' <- getState >>= (liftIO . readIORef . notes)
    lucid $ do
        h1_ "Notes"
        ul_ $ forM_ notes' $ \note -> li_ $ do
            toHtml (author note)
            ": "
            toHtml (contents note)

main :: IO ()
main = do
    st <- ServerState <$> 
        newIORef [ Note "Alice" "Do something"
                 , Note "Bob" "Do something else" ]
    cfg <- defaultSpockCfg () PCNoDatabase st
    runSpock 8080 (spock cfg app)
