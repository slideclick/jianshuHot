#!/bin/bash
# File Name: start.sh
# Author: JackeyGao
# mail: junqi.gao@shuyun.com
# Created Time: 三  1/ 6 15:33:06 2016

cd $(dirname $0)
source /etc/profile
source ~/.virtualenvs/spider/bin/activate

echo "删除旧数据 - note"
python -c "from jianshu.db import delete_note; delete_note()"

echo "删除旧数据 - notef"
find ./output/markdown -type f -delete

echo "删除旧数据 - image"
python -c "from jianshu.db import delete_image; delete_image()"

echo "删除旧数据 - imagef"
find ./output/images -type f -delete

echo "重新抓取中 - note"
scrapy crawl jianshu_hot 

echo "重新抓取中 - image"
python -c "from jianshu.image import request_images; request_images()"

echo "生成markdown"
python -c "from jianshu.book import gen_markdown; gen_markdown()"

echo "生成gitbook"
python -c "from jianshu.book import gen_book; gen_book()"

