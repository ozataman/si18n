module Text.Si18n.ByteString

( module Text.Si18n.ByteString
, t
, t'
, S.loadI18nFile
) where

import qualified Data.Map as Map
import qualified Data.Text as T
import qualified Data.ByteString.Char8 as B
import           Data.ByteString (ByteString)
import           Data.Text (Text)
import           Data.Text.Encoding

import           Text.Si18n.Loader
import           Text.Si18n.Types
import qualified Text.Si18n as S


-----------------------------------------------------------------------------
-- | Translate a given key with the given token mapping.
t :: I18nData                     -- ^ Translation data
  -> ByteString                   -- ^ Locale
  -> ByteString                   -- ^ Key
  -> [(ByteString, ByteString)]   -- ^ Token values
  -> ByteString
t i18n l s m = encodeUtf8 $ S.t i18n l' s' m'
  where
    (l':s':_) = map decodeUtf8 [l, s]
    m' = map (\(k,v) -> (decodeUtf8 k, decodeUtf8 v)) m



-----------------------------------------------------------------------------
-- | Same as 't' but you don't need to supply a token mapping.
t' :: I18nData -> ByteString -> ByteString -> ByteString
t' i18n l s = t i18n l s []
