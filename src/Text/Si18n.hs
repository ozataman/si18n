module Text.Si18n 

( module Text.Si18n.Types
, t
, t'
, loadI18nFile
) where

import           Data.List (foldl')
import qualified Data.Map as Map
import qualified Data.Text as T
import           Data.Text (Text)

import           Text.Si18n.Loader
import           Text.Si18n.Types


tToken :: [(Text, Text)] -> I18nToken -> Text
tToken m ts = T.concat $ foldl' render [] ts
  where
    render a (TransToken x) = val x : a
    render a (Piece x) = x : a
    val x = maybe (errtext x) id $ lookup x m
    errtext x = T.concat ["[i18n token not supplied: ", x, " ]"]


-----------------------------------------------------------------------------
-- | Translate a given key with the given token mapping.
t :: I18nData   -- ^ Translation data
  -> Text       -- ^ Locale
  -> Text       -- ^ Key
  -> TokenMap   -- ^ Token values
  -> Text
t i18n l s m = maybe (errtext s) (tToken m) token 
  where
    errtext x = T.concat ["[i18n translation missing: ", x, " ]"]
    token     = Map.lookup k i18n
    k         = T.concat [l, ".", s]


-----------------------------------------------------------------------------
-- | Same as 't' but you don't need to supply a token mapping.
t' :: I18nData -> Text -> Text -> Text
t' i18n l s = t i18n l s []
