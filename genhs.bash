#!/bin/bash

cat <<EOF
{-# LANGUAGE OverloadedStrings #-}

import Text.Blaze.XHtml5
import qualified Text.Blaze.XHtml5 as H
import Text.Blaze.XHtml5.Attributes
import qualified Text.Blaze.XHtml5.Attributes as A
import Text.Blaze.Html.Renderer.Pretty

a' link = a ! href link
divId id_ = H.div ! A.id id_
divClass cl = H.div ! class_ cl
script' link = script ! src link ! type_ "text/javascript" $ ""

main = putStrLn . renderHtml $ do
EOF

sed 's/^/  /' $1
