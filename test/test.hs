module Test where

import           Text.Si18n
import           Text.Si18n.Loader
import           Text.Si18n.Types



i18n :: IO I18nData
i18n = loadI18nFile "test/en.csv"
