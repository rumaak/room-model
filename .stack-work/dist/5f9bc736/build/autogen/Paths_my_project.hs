{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_my_project (
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

bindir     = "E:\\dropbox\\Dropbox\\Haskell\\my-project\\.stack-work\\install\\3d04ff67\\bin"
libdir     = "E:\\dropbox\\Dropbox\\Haskell\\my-project\\.stack-work\\install\\3d04ff67\\lib\\i386-windows-ghc-8.0.2\\my-project-0.1.0.0"
dynlibdir  = "E:\\dropbox\\Dropbox\\Haskell\\my-project\\.stack-work\\install\\3d04ff67\\lib\\i386-windows-ghc-8.0.2"
datadir    = "E:\\dropbox\\Dropbox\\Haskell\\my-project\\.stack-work\\install\\3d04ff67\\share\\i386-windows-ghc-8.0.2\\my-project-0.1.0.0"
libexecdir = "E:\\dropbox\\Dropbox\\Haskell\\my-project\\.stack-work\\install\\3d04ff67\\libexec"
sysconfdir = "E:\\dropbox\\Dropbox\\Haskell\\my-project\\.stack-work\\install\\3d04ff67\\etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "my_project_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "my_project_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "my_project_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "my_project_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "my_project_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "my_project_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "\\" ++ name)
