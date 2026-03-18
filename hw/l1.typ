#set text(font: "New Computer Modern", size: 12pt)

// 定义一个简单的样式函数来模拟图片中的数字序列背景
#let seq(content) = box(
  // fill: gray.lighten(90%),
  // inset: (x: 4pt, y: 4pt),
  // radius: 4pt,
  raw(content)
)

#grid(
  columns: (auto, auto, auto),
  column-gutter: 8pt,
  row-gutter: 12pt,
  align: horizon,
  
  // 第一行
  [原数组], $seq("(45, 33, 24, 45, 12, 12, 24, 12)")$, [],
  
  // 第二行
  [Step1], $seq("(12, 33, 24, 45, 12, 12, 24, 45)")$, [],
  
  // 第三行
  [Step2], $seq("(12, 33, 24, 24, 12, 12, 45, 45)")$, [],
  
  // 第四行
  [Step3], $seq("(12, 12, 24, 24, 12, 33, 45, 45)")$, [],
  
  // 第五行
  [Step4], $seq("(12, 12, 12, 24, 24, 33, 45, 45)")$

)
此后有序,只比较不改变元素位置.一共比较$sum$