{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_TodoApi (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/patryk/.cabal/bin"
libdir     = "/home/patryk/.cabal/lib/x86_64-linux-ghc-8.6.5/TodoApi-0.1.0.0-9Jm1vsATKe6JmuX9aLcCht-TodoApi"
dynlibdir  = "/home/patryk/.cabal/lib/x86_64-linux-ghc-8.6.5"
datadir    = "/home/patryk/.cabal/share/x86_64-linux-ghc-8.6.5/TodoApi-0.1.0.0"
libexecdir = "/home/patryk/.cabal/libexec/x86_64-linux-ghc-8.6.5/TodoApi-0.1.0.0"
sysconfdir = "/home/patryk/.cabal/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "TodoApi_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "TodoApi_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "TodoApi_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "TodoApi_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "TodoApi_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "TodoApi_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
