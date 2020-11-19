# Latex源代码文件的基本结构

+ 在texmaker新建文件的快捷命令: Ctrl+N


+ 分区
  + 导言区:用于设置全局
    + \\documentclass{article }  or book report letter
    + 标题：\\title{}
    + 作者：\\author{}
    + 时间: \\date{\today}
  + 正文区(文稿区)
    + 一个latex文件只能有一个document
    + \\begin{document}
    + \\end{document}
    + 行注释符号 $\%$
  + 文本模式和数学模式
    + \$  \$包裹起来的就是数学模式,行内公式
    + \$\$  \$\$, 行间公式