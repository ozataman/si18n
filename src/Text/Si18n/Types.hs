module Text.Si18n.Types where

import           Data.Map (Map)
import           Data.Text (Text)


-----------------------------------------------------------------------------
-- | Key-Value pairs that the user will supply for when there are token
-- substitutions in the translation text.
type TokenMap = [(Text,Text)]


-----------------------------------------------------------------------------
-- | In-memory representation of I18n translation data
type I18nData = Map Text I18nToken


-----------------------------------------------------------------------------
-- | Translation data for a single key
type I18nToken = [Segment]


-----------------------------------------------------------------------------
-- | Part of a single translation
data Segment = TransToken Text
             | Piece Text
             deriving (Show, Eq)
