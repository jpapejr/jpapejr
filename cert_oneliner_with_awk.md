`awk 'NF {sub(/\r/, ""); printf "%s\\n",$0;}' <certificate name>` will do it. 