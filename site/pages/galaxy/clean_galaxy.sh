for f in *.md; do
  sed -i -E '
    s/\{\%\s*icon\s+galaxy-pencil\s*\%\}/✏️/g;
    s/\{\%\s*icon\s+galaxy-run\s*\%\}/▶️/g;
    s/\{\%\s*icon\s+galaxy-eye\s*\%\}/👁️/g;
    s/\{\%\s*icon\s+galaxy-chart\s*\%\}/📊/g;
    s/\{\%\s*icon\s+galaxy-copy\s*\%\}/📋/g;
    s/\{\%\s*icon\s+external-link\s*\%\}/🔗/g;
    s/\{\%\s*tool\s*"([^"]+)"\s*\%\*/**\1**/g;
    s/\{\%\s*(snippet|include).*?\%\}//g;
    s/\{\%.*?\%\}//g;
  ' "$f"
  echo "✅ Cleaned $f"
done
