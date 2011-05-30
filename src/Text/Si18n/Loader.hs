module Text.Si18n.Loader 
(loadI18nFile) where


import           Control.Exception
import qualified Data.ByteString.Char8 as B
import           Data.ByteString (ByteString)
import           Data.List (foldl')
import qualified Data.Map as Map
import           Data.Map (Map)
import qualified Data.Text as T
import           Data.Text (Text)
import qualified Data.Text.Encoding as E

import           Data.CSV.Enumerator

import           Text.Si18n.Types


loadI18nFile :: FilePath -> IO I18nData
loadI18nFile f = do
  ds <- foldCSVFile f defCSVSettings (funToIter i18nLoader) Map.empty 
  return $ either (\e -> error $ "Can't load locale file. Caught error: "
                    ++ show e) id ds


i18nLoader :: I18nData -> ParsedRow Row -> I18nData
i18nLoader a (ParsedRow (Just r)) = Map.insert k' v' a
  where (k:v:l:_) = map E.decodeUtf8 r
        k' = T.concat [l, ".", k]
        v' = tokenize v
i18nLoader a _ = a


tokenize :: Text -> I18nToken
tokenize t = foldl' collect [] rsplits
  where
    lsplits = T.splitOn "{{" t
    rsplits = concat $ map (T.splitOn "}}") lsplits

    collect a@((Piece _):_) x = TransToken x : a
    collect a x               = Piece x : a
