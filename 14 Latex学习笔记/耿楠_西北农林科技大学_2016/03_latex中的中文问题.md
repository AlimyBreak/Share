# Latex中的中文处理方法
+ 在能处理宽字节的软件XeTeX版本发行之前，一般通过中科大的CTEX和德国的CJK
+ 现在的做法
  + 构建命令中选编译器: XeLatex
  + 编辑器的编码格式： UTF-8
  + 源文件在documentclass下面引入一个ctex的宏保
    + \usepackage{ctex}


+ 命令行工具查看ctex的手册
  + texdoc ctex
  + texdox lshort-zh
