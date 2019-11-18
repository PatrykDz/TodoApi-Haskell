{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Main where

import Control.Monad.IO.Class (liftIO)
import Control.Monad (forM_)
import Web.Spock
import Web.Spock.Config
import Web.Spock.Lucid (lucid)
import Lucid

import Data.Aeson hiding (json)
import Data.Semigroup ((<>))
import Data.Monoid ((<>))
import Data.Text (Text, pack)
import Data.Bool (Bool)
import Data.IORef
import GHC.Generics

data Todo = Todo 
    {
    content :: Text
    } deriving (Generic, Show)

instance ToJSON Todo

instance FromJSON Todo

newtype ServerState = ServerState { todos :: IORef [Todo] }

type Api = SpockM () () () ()

type ApiAction a = SpockAction () () () a

main :: IO ()
main = do
    spockCfg <- defaultSpockCfg () PCNoDatabase ()
    runSpock 8080 (spock spockCfg app)

app :: Api
app = do
    get "todos" $ do
        json $ Todo { content="Some contents" }
    post "todos" $ do
        theTodo <- jsonBody' :: ApiAction Todo
        text $ "Parsed: " <> pack (show theTodo)
        
