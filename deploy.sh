#!/bin/bash

echo -e "\033[32m hexo g 构建 \033[0m"
hexo g

git add .
git commit -m "update"

echo -e "\033[32m 推送到远程仓库 \033[0m"
git push
echo -e "\033[32m 发布网站 \033[0m"
curl http://106.13.43.91:8888/hook?access_key=wQb8qzDNuOGhLQi8IilBau4jnuBRQiiHmXbfF0r6iamKb6wy
