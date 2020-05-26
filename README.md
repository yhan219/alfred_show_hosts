
Alfred是macOS上屡获殊荣的应用程序，可通过热键，关键字，文本扩展等功能提高效率。搜索Mac和网络，并通过自定义操作来控制Mac来提高生产力。

## 新建一个workflow
点击左下角`+`-->`Templates`-->`Essentials`-->`Script Filter to Script`，填写`name`和`icon`,新建完成后如下：

![](https://gitee.com/yhan219/blog-image/raw/master/yhan/alfred-1.png)

## 修改`Script Filter`
双击第一个图形，进入修改页面，其中
- `keyword`填写关键字，如`hosts`
- `参数`选项选`Argument Optional`,即参数选填
- `language`选`/bin/bash`,`with input as argv`
  - `with input as argv`参数通过`query=$1`获取
  - `with input as query`参数通过`query="{query}"`获取

## 编写脚本
``` shell
#!/bin/bash

HOSTS=""
# Handle action
if [[ "$1" != "" ]]; then
  if [[ "$1" == "Null" ]]; then
    exit
  fi
  HOSTS=`cat /etc/hosts | grep '^[^#].*' | grep $1`
else
 HOSTS=`cat /etc/hosts | grep '^[^#].*'`
fi
echo "<?xml version='1.0'?><items>"
while read -r HOST; do
  ARRAY=(${HOST// / })
  echo "<item uid='${ARRAY[0]}' arg='${ARRAY[0]}'><title>${ARRAY[1]}</title><subtitle>${ARRAY[0]}</subtitle></item>"
done <<< "$HOSTS"
echo "</items>"

```

`alfred workflow`主要是通过构建如下结构并输入：
```xml
<?xml version="1.0" encoding="utf-8"?>

<items> 
  <item uid="id" arg="参数，可传递到下一个流程" valid="yes" autocomplete="yes">
    <title>标题</title>
    <subtitle>副标题)</subtitle>
    <icon>图标，缺省显示应用图标</icon>
  </item> 
</items>

```

填写完成后如下：
![](https://gitee.com/yhan219/blog-image/raw/master/yhan/alfred-2.png)

## 添加`粘贴`
我们需要将选中的`ip`复制到粘贴板
- 界面上删除第二个图形
- 右键新建粘贴图形，`右键`-->`Outputs`-->`Copy to Clipboard`,弹出框直接`save`即可
- 界面上从图形一拉一条线到图形二即可
完成后如下：
![](https://gitee.com/yhan219/blog-image/raw/master/yhan/alfred-3.png)

## 效果图
![](https://gitee.com/yhan219/blog-image/raw/master/yhan/hb7eD9.png)
选中选项后，回车，IP即拷贝到粘贴板

## 参考文献
[Help and Support > Workflows](https://www.alfredapp.com/help/workflows/)

> [https://blog.yhan219.com/alfred-workflow/](https://blog.yhan219.com/alfred-workflow/)