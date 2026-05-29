


#import "@local/ysz_tools:0.1.0": *
#show: conf

= chapter9: 分支限界法
<chapter9-分支限界法>
== 分支-限界法基本原理
<分支-限界法基本原理>
- #strong[分支-限界法定义]：生成当前E-结点（扩展结点）的全部子结点（分支），利用剪枝函数对不能生成含答案结点的子树剪枝（限界）的状态空间树检索方法。即，每当访问一个结点（E-结点）时，会生成这个结点的所有子结点（广度优先搜索）

- #strong[核心要素]：多个活节点的组织，E-节点的检索，剪枝函数的设计

- #strong[FIFO检索策略]：类似于BFS的状态空间检索，活结点采用普通队列组织（first
  in first out），选择方式太过死板，不利于答案的得到。

- #strong[LIFO检索策略]：类似于D-检索的状态空间检索，活结点表采用栈组织（last
  in first out）

- #strong[最优检索策略]：最小耗费（最大收益）的方式检索，活结点表采用优先级队列组织

目标状态是否可由初始状态到达的判定方法：对于15-迷问题（4\*4棋盘内通过合法移动恢复成目标排列）

给4×4棋盘的方格编号$1 tilde.op 16$位置$i$表示目标排列中放$i$号牌的方格位置，位置16是空格的位置。

$P O S I T I O N \( i \)$：编号$i$的牌在初始状态的位置号（$1 lt.eq i < 16$）$P O S I T I O N \( 16 \)$：空格的位置号，$L E S S \( i \)$：满足${ j \| j < i and P O S I T I O N \( j \) > P O S I T I O N \( i \) }$的数目。

若初始状态空格横纵坐标和为奇数，$X = 1$；否则$X = 0$.

当且仅当$sum_(i = 1)^16 L E S S \( i \) + X$为偶数时，目标状态可由初始状态到达。

- #strong[活结点管理]：使用优先队列（堆结构）组织活结点，每个结点按\"成本估计值\"排序，总是扩展当前成本最小的结点

- #strong[成本计算]：对于已部分解$x \[ 1 . . k \]$，计算已发生成本（从根到当前结点的实际代价）和预估成本（启发式函数估算完成解所需的最小代价），总成本=已发生成本+预估成本(结点的成本估计函数：$hat(c) \( X \) = f \( h \( X \) \) + hat(g) \( X \)$.如果$X$是一个答案结点或是一个叶子结点，则有$c \( X \) = hat(c) \( X \)$)

  - $hat(g) \( X \)$是由$X$到达一个答案结点所需做的附加工作的估计

  - $h \( X \)$是由根结点到结点$X$的成本

  - $f \( dot.op \)$是一个非降函数。$f$函数强使算法优先选择更靠近答案结点但又离根较近的结点。它也能调整$h \( X \)$和$hat(g) \( X \)$在$hat(c) \( X \)$中的影响比例。

- #strong[搜索过程]：

  + 初始化优先队列（加入根结点）

  + 循环直到队列为空：

    - 取出队首（成本最小的E-结点）

    - 生成所有子结点

    - 对每个子结点计算成本估计值，检查剪枝条件（若成本$>$当前最优解则丢弃），存活结点入队

    - 若到达叶结点则更新最优解

LC-检索的两种特殊情况：

+ 当$f \( h \( x \) \)$=结点X的级数，且$hat(g) \( X \) = 0$时(忽略未来成本，只考虑历史成本，因而先考虑浅层结点)：若结点的$hat(c)$值相同，选取最先生成的活结点.此时LC-检索等价于BFS检索（队列实现的宽度优先搜索）

+ 当$f \( h \( x \) \) = 0$，且满足$forall Y in upright("children") \( X \) \, hat(g) \( X \) gt.eq hat(g) \( Y \)$时(忽略历史成本，只考虑未来成本，因而先考虑深层结点)：若结点的$hat(c)$值相同，选取最晚生成的活结点.此时LC-检索等价于D-检索（堆栈实现活结点表）

成本函数$c \( dot.op \)$：从根出发到最近目标结点路径上的每个结点赋予这条路径的长度作为它们的成本。

估计成本函数$hat(c) \( dot.op \)$：$hat(c) \( X \) = h \( X \) + hat(g) \( X \)$

- $h \( X \)$是由根到结点$X$的路径的长度

- $hat(g) \( X \)$是对以$X$为根的子树中由$X$到目标状态的一条路径长度的估计。它至少应是能把状态$X$转换成目标状态所需的最小移动数

- $hat(g) \( X \) =$不在其目标位置的非空白牌数目

- 可以看出$hat(c) \( X \)$是$c \( X \)$的下界

#block[
  $E arrow.l T$ $P A R E N T \( E \) arrow.l 0$ 初始化活结点表为空

]
$epsilon$确保$l b \( X \) < l b \( Y \) arrow.r.double l b \( X \) - epsilon < l b \( Y \)$,消除了边界值相等时的判断歧义.

== 分支限界法的应用
<分支限界法的应用>
分支限界法的核心在于#strong[cost函数设计]，通过评估部分解的潜在最优性实现高效剪枝。其通用模板为：

+ 初始化优先队列（按cost排序）

+ 扩展当前最优部分解的子节点

+ 计算子节点的cost值并剪枝

=== Cost函数设计方法
<cost函数设计方法>
#figure(
  align(center)[#table(
    columns: 3,
    align: (left, center, center),
    table.header(
      [#strong[方法]],
      [#strong[Cost函数形式]
        $bold(C_(m e t h o d))$],
      [#strong[紧致性] $bold(rho)$],
    ),
    table.hline(),
    [MST下界], [$C = L_(c u r r e n t) + W_(M S T)$], [中等],
    [线性松弛], [$C = V_(s e l e c t e d) + sum (v_i dot.op min (1 \, W_(r e m a i n) / w_i))$], [高],
    [贪心启发式], [$C = C_(c u r r e n t) + hat(C)_(r e m a i n)$], [低--中],
    [曼哈顿距离], [$C = g \( n \) + h \( n \)$], [低],
  )],
  caption: [经典Cost函数对比：实际计算与理论性质],
  kind: table,
)

对于线性松弛方法中的Cost函数：

$ C = V_(upright("selected")) + sum (v_i times min (1 \, W_(upright("remain")) / w_i)) $

其中：

- $V_(upright("selected"))$ = 当前已选物品的总价值

- $W_(upright("remain"))$ = 背包/容器的剩余可用容量

- $v_i$ = 第$i$个物品的价值

- $w_i$ = 第$i$个物品的重量/体积

公式含义：

+ $min (1 \, W_(upright("remain")) / w_i)$
  计算每个物品能放入剩余容量的最大比例

  - 当$W_(upright("remain")) / w_i gt.eq 1$时，可取完整物品（比例=1）

  - 当$W_(upright("remain")) / w_i < 1$时，只能取部分物品（比例\<1）

+ $v_i times min \( . . . \)$ 表示该物品的实际贡献价值

+ 求和项$sum$计算所有未选物品的潜在最大价值

典型应用场景：

- 背包问题（Knapsack Problem）的线性规划松弛

- 资源分配问题中计算理论上界

- 分支定界法中的界限估计

=== 关键实现技术
<关键实现技术>
#block[
]
采用MST下界作为cost函数：
$ c o s t \( pi \) = sum_(i = 1)^k d_(pi \( i \)) + upright("MST") \( upright("未访问城市") \) $
其中$pi$为已访问路径，$d_(pi \( i \))$为路径长度。

使用线性松弛上界：
$ c o s t \( S \) = sum_(i in S) v_i + sum_(j in.not S) v_j dot.op min (1 \, frac(W - sum_(i in S) w_i, w_j)) $

=== TSP问题中的MST下界
<tsp问题中的mst下界>
$ C_(upright("MST")) = L_(upright("current")) + W_(upright("MST")) $

- #strong[变量说明]：

  - $L_(upright("current"))$：当前已构建路径的总长度

  - $W_(upright("MST"))$：剩余未访问节点最小生成树(MST)的边权和

- #strong[计算原理]：

  + 通过Prim或Kruskal算法计算剩余节点的MST

  + MST权值和$W_(upright("MST"))$是连接剩余节点的最小代价

  + 最终路径长度 $gt.eq L_(upright("current")) + W_(upright("MST"))$

- #strong[示例]：

  ```python
  def tsp_lower_bound(current_path, remaining_nodes):
          mst = compute_mst(remaining_nodes)  # 计算剩余节点MST
          return current_path.length + mst.total_weight
  ```

=== 背包问题中的线性松弛
<背包问题中的线性松弛>
$
  C_(upright("LP")) = V_(upright("selected")) + sum_(i in upright("剩余物品")) (v_i times min (1 \, W_(upright("remain")) / w_i))
$

- #strong[变量说明]：

  - $V_(upright("selected"))$：已选物品总价值

  - $W_(upright("remain"))$：背包剩余容量

  - $v_i \/ w_i$：物品的价值-重量比

- #strong[计算原理]：

  + 对剩余物品按$v_i \/ w_i$降序排序

  + 尽可能装入高价值密度物品（可分割）

  + $min$函数确保不超过物品本身价值

- #strong[分支定界法中的应用]：
  $ upright("全局上界") = max_(upright("所有节点")) C_(upright("LP")) $

- #strong[算法实现]：

  ```python
  def knapsack_upper_bound(selected, remaining):
      sorted_items = sorted(remaining, key=lambda x: x.v/x.w, reverse=True)
      bound = selected.total_value
      for item in sorted_items:
          if W_remain <= 0: break
          take = min(1, W_remain/item.w)
          bound += take * item.v
          W_remain -= take * item.w
      return bound
  ```
