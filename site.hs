{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid ((<>), mappend, mconcat)
import           Hakyll
import           Text.Pandoc.Options (readerSmart)

main :: IO ()
main = hakyll $ do
    match "images/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match "templates/*" $ compile templateCompiler

    match "*.html" $ do
        route $ setExtension "html"
        compile $ do
            let indexCtx = defaultContext
            getResourceBody
                >>= loadAndApplyTemplate "templates/default.html" defaultContext
                >>= relativizeUrls
