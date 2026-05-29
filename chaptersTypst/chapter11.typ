


#import "@local/ysz_tools:0.1.0": *
#show: conf

= chapter11: 近似算法
<chapter11-近似算法>
== 导入
<导入>
=== 组合优化问题
<组合优化问题>
组合优化问题$Pi$不是最小化问题就是最大化问题。它由三个部分组成：

+ 一个实例集合$D_Pi$；

+ 对于每个实例$I in D_Pi$，存在$I$的一个候选解的有限集合$S_Pi \( I \)$；

+ 实例$I in D_Pi$的每个解$sigma in S_Pi \( I \)$，存在一个值$f_Pi \( sigma \)$，称为$sigma$的解值。

- 如果$Pi$是最小化问题，那么实例$I in D_Pi$的最优解$sigma^(*)$满足：
  $ forall sigma in S_Pi \( I \) \, med f_Pi \( sigma^(*) \) lt.eq f_Pi \( sigma \) $

- 最大化问题的最优解类似定义：
  $ forall sigma in S_Pi \( I \) \, med f_Pi \( sigma^(*) \) gt.eq f_Pi \( sigma \) $

- 最优解值记为$O P T \( I \) = f_Pi \( sigma^(*) \)$。

=== 近似算法
<近似算法>
最优化问题$Pi$的一个近似算法$A$是一个（#strong[多项式时间]）算法，给定一个实例$I in D_Pi$，算法输出某个解$sigma in S_Pi \( I \)$。算法$A$得到的解也称为近似解，值$f_Pi \( sigma \)$记为$A \( I \)$。

数学表达：

- 问题实例：$I in D_Pi$

- 可行解集：$S_Pi \( I \)$

- 近似解：$sigma in S_Pi \( I \)$

- 解值表示：$A \( I \) = f_Pi \( sigma \)$

=== 装箱问题
<装箱问题>
- #strong[问题定义]：给定一个大小在0和1之间的物品集合，将这些物品装到容量为1的箱子中，要求使用箱子数目最少（最小化问题）。

- #strong[实例集$D_Pi$]：由所有实例$I = { s_1 \, s_2 \, dots.h \, s_n }$组成，其中$forall j med \( 1 lt.eq j lt.eq n \)$，有$s_j in \( 0 \, 1 \]$。

- #strong[解集合$S_Pi \( I \)$]：由子集集合$sigma = { B_1 \, B_2 \, dots.h \, B_k }$构成，满足：

  + $sigma$是$I$的不相交划分

  + $forall j med \( 1 lt.eq j lt.eq k \) \, med sum_(s in B_j) s lt.eq 1$

- #strong[解值]：$f_Pi \( sigma \) = \| sigma \| = k$（使用的箱子数量）。

- 最优解是符合条件的具有最小子集数的$sigma$。

- 令$A$是为每一物品分配一个箱子的（平凡）算法。根据定义（$A$的时间复杂度是多项式级别的），$A$是一个近似算法。但显然，$A$不是一个好的近似算法。

=== 差界
<差界>
- 对于问题的所有实例$I$，希望近似算法$A$满足：
  $ \| A \( I \) - O P T \( I \) \| lt.eq K quad \( K upright("为常数") \) $

- #strong[定义]：若对每个实例$I$都有
  $ O P T \( I \) - K lt.eq A \( I \) lt.eq O P T \( I \) + K arrow.l.r.double \| A \( I \) - O P T \( I \) \| lt.eq K $

  则称算法$A$具有#strong[有界误差]或#strong[差界]$K$

- 这也称为近似算法的#strong[绝对性能保证]（absolute performance
  guarantee）

- 适用于绝对误差敏感的场景（如资源分配问题中固定容量的偏差）

- 只有很少的NP困难问题已知差界

=== 相对性能界
<相对性能界>
- #strong[定义]：设$A$是求解优化问题$Pi$的近似算法，$I$是$Pi$的实例
  $ R_A \( I \) = max (frac(A \( I \), O P T \( I \)) \, frac(O P T \( I \), A \( I \))) gt.eq 1 $

- 称为解$A \( I \)$的#strong[近似度]（近似比）

- 提供了算法解质量的统一测度，也称#strong[相对近似度]

- #strong[绝对近似度]：
  $ R_A = inf thin { r gt.eq 1 divides R_A \( I \) lt.eq r \, med forall I in D_Pi } $
  表示所有实例上的最大近似度

- #strong[渐进近似度]：
  $
    R_A^oo = inf thin { r gt.eq 1 divides exists N \, med R_A \( I \) lt.eq r \, med forall I in D_Pi \, med \| I \| gt.eq N }
  $
  表示足够大实例上的近似度

=== 近似方案
<近似方案>
- #strong[定义]：最优化问题的#strong[近似方案]是算法簇${ A_epsilon }_(epsilon > 0)$，满足
  $ R_(A_epsilon) lt.eq 1 + epsilon $

- 近似方案是近似度收敛于1的一系列算法

- 可视为算法$A$，输入实例$I$和误差界$epsilon$，满足
  $ R_A \( I \, epsilon \) lt.eq 1 + epsilon $

- #strong[多项式近似方案(PAS)]：近似方案${ A_epsilon }_(epsilon > 0)$中，每个$A_epsilon$在$\| I \|$的多项式时间内运行。注意：PAS的运行时间对$\| I \|$是多项式，但对$1 \/ epsilon$可能非多项式

- #strong[完全多项式近似方案(FPAS)]是近似方案${ A_epsilon }_(epsilon > 0)$，每个$A_epsilon$在$\| I \|$和$1 \/ epsilon$的多项式时间内运行

- #strong[伪多项式时间算法]：在$L$的多项式时间内运行的算法，其中$L$是输入实例的最大数值。示例：0/1背包问题的动态规划算法（运行时间$O \( n C \)$）是伪多项式时间算法。注：若算法在$log L$的多项式时间内运行，则是严格多项式时间算法

- #strong[FPAS构造方法]：对存在伪多项式时间算法$A$的NP难问题：

  + 对实例$I$的数值进行标度变换和舍入，得到$I'$

  + 将$A$应用于$I'$得到近似解

#figure(
  align(center)[#table(
    columns: 4,
    align: (center, center, center, center),
    table.header([#strong[类型]], [#strong[时间复杂度]], [#strong[解质量]], [#strong[典型问题]]),
    table.hline(),
    [PTAS], [$O \( n^(f \( 1 \/ epsilon.alt \)) \)$], [$\( 1 + epsilon.alt \)$-近似], [欧几里得TSP],
    [FPTAS], [$O \( \( 1 \/ epsilon.alt \)^k n^c \)$], [$\( 1 + epsilon.alt \)$-近似], [0-1背包],
    [伪多项式算法], [$O \( N^k n^c \)$], [可能为精确解], [子集和问题],
  )],
  caption: [#strong[近似算法对比]],
  kind: table,
)

=== 可近似性分类
<可近似性分类>
+ #strong[完全可近似的]（Fully Approximable）：

  - 定义：对任意小的$epsilon > 0$，存在$\( 1 + epsilon \)$-近似算法

  - 典型问题：0/1背包问题

+ #strong[可近似的]（Approximable）：

  - 定义：存在具有常数比的近似算法（如2-近似）

  - 典型问题：最小顶点覆盖问题、多机调度问题

+ #strong[不可近似的]（Inapproximable）：

  - 定义：除非P=NP，否则不存在具有常数比的近似算法

  - 典型问题：货郎问题（TSP）

== 可近似算法举例
<可近似算法举例>
=== 装箱问题
<装箱问题-1>
会有四种启发式方法，最先匹配(FF，
分配第一个能装的箱子)，最佳匹配(BF，分配能装的箱子里面剩余空间最小的)，递减最先匹配(FFD)，递减最佳匹配(BFD)。下面我们对FF进行近似度分析：

假定：箱子容量为1个单位体积，物品大小
$s_i lt.eq 1$（$i = 1 \, 2 \, dots.h \, n$）。

定义：

- $F F \( I \)$ 表示在实例 $I$ 下，使用FF算法装入物品时所用的箱子数目

- $O P T \( I \)$ 表示最优装入时所用的箱子数目

FF装箱规则说明：

- 根据FF装箱规则，#strong[至多有一个非空箱子]所装的物品体积 $< 1 / 2$

- 若存在两个这样的箱子 $b_i$, $b_j$（$i < j$），由于它们装的物品体积均
  $< 1 / 2$，根据算法规则，$b_j$ 中的物品应被装入 $b_i$ 而非新箱子

#block[
  给定若干个物品，判断它们是否可由两个箱子装下是NP-完全的。

]
#block[
  #emph[Proof.] 可由划分问题（Partition
  problem）规约。划分问题是Karp的21个NP-完全问题之一，该问题表述为：给定若干个正整数，问可否将其划分成和相等的两个部分；换言之，给定$c_1 \, c_2 \, dots.h \, c_n in bb(Z)^(+)$，划分问题问是否存在一个$S subset.eq { 1 \, 2 \, dots.h \, n }$使得
  $ sum_(i in S) c_i = sum_(i in.not S) c_i $

  根据一个划分问题实例，我们可以构造一个装箱问题，令物品的尺寸为：
  $ a_i = frac(2 c_i, sum_(j = 1)^n c_j) \, quad i = 1 \, 2 \, dots.h \, n $
  同时我们假设这些$a_i in \( 0 \, 1 \]$。由于$sum_(i = 1)^n a_i = 2$，如果这些物品能用两个箱子装下，那么这两个箱子都正好装满，这也同时解答了划分问题。这样我们就把一个已知的NP-完全问题规约为了两个箱子的装箱问题。而显然一个给定的装箱问题的解可在多项式时间内验证，因此该问题是NP-完全的。~◻

]
要证明问题$L$是NP-完全的，只需证明：
​存在性​：已知的某个NP-完全问题（如划分问题）可规约到$L$
​无关性​：不要求$L$的所有实例都满足某种特性，只需特定构造的实例能覆盖原问题的解空间

我们之前衡量近似算法采用的是绝对近似比，定义为最坏情况下算法的求解值与问题的最优值之间的比率。对任意实例$I$，用$A \( I \)$表示针对实例$I$运行算法$A$后所用箱子数；$O P T \( I \)$表示装完实例$I$中所有物品所用的最少箱子数。若存在常数$alpha gt.eq 1$，对任意实例$I$有：
$ A \( I \) lt.eq alpha dot.op O P T \( I \) $
则算法$A$的近似比至多是$alpha$。

#block[
  除非$sans(P) = sans(N P)$，否则装箱问题不存在多项式时间算法具有小于$3 / 2$的绝对近似比。

]
#block[
  #emph[证明（反证法）.]
  假设存在近似比小于$3 / 2$的多项式时间近似算法$A$，分类讨论：

  - 当$O P T \( I \) = 2$时：
    $ A \( I \) < 3 / 2 times 2 = 3 arrow.r.double.long A \( I \) = 2 = O P T \( I \) $

  - 当$O P T \( I \) gt.eq 3$时： $ A \( I \) gt.eq 3 $

  此时算法$A$可精确判定\"是否能用两个箱子装下\"的问题，而该问题是#emph[NP-完全的]。若$sans(P) eq.not sans(N P)$，则导致矛盾。~◻

]
虽然$O P T \( I \) = 2$的情况直接揭示了矛盾的核心（算法$A$被迫精确求解NP-完全问题），但​必须验证$O P T \( I \) gt.eq 3$时的行为，才能确保反证假设的全局一致性。这是复杂性理论证明中"规约+反证"方法的严谨性体现。

#block[
  对任意常数$alpha gt.eq 1$，任意实例$I$，若存在常数$k$满足：
  $ A \( I \) lt.eq alpha dot.op O P T \( I \) + k quad upright("(AAR)") $<AAR>
  则称所有满足上式的$alpha$的下确界为算法$A$的#strong[渐进近似比]。其中：

  - $alpha$决定当$O P T \( I \)$充分大时$A \( I \)$与$O P T \( I \)$的比值

  - $k$可以是：

    - 固定常数，或

    - $o \( O P T \( I \) \)$（满足$lim_(O P T \( I \) arrow.r oo) frac(k, O P T \( I \)) = 0$）

  - 当$k = 0$时，渐进近似比退化为#strong[绝对近似比]

]
#block[
  对于任意的实例$I$,有：
  $ F F \( I \) lt.eq 17 / 10 O P T \( I \) + 4 / 5 $ (常数ppt中为2,
  $B F$同为$17 / 10$)

]
后续再做展开：#link("https://zhuanlan.zhihu.com/p/685478438")

#block[
  对于任意的实例$I$,有： $ F F D \( I \) lt.eq 11 / 9 O P T \( I \) + 4 $
  ($B F D$同为$11 / 9$)

]
=== ETSP问题
<etsp问题>
给定一个平面上$n$个点的集合$S$，找出一个在这些点上的最短长度的游程$t$。这里一个游程是恰好访问每个点一次的一条回路。

ETSP问题是TSP问题的特殊情况，点之间的距离是欧式距离，满足三角不等关系。
对于最近邻(NN)法：采用贪心法，设$p_1$是任意一个起始点，下一个访问距离$p_1$最近的点，比如$p_2$，再继续访问距离$p_2$最近的点，直到回到$p_1$。

#block[
  对于ESTP问题所有满足三角不等书的$n$个城市的实例$I$,有：
  $ N N \( I \) lt.eq 1 / 2 \( ceil.l log_2 n ceil.r + 1 \) O P T \( I \) . $
  而且，对于每一个充分大的$n$，存在满足三角不等式的$n$个城市的实例$I$使得：
  $ N N \( I \) > 1 / 3 \( log_2 \( n + 1 \) + 4 / 3 \) O P T \( I \) . $

]
很明显这里对于$N N$的近似比：
\$\$R\_{NN}(I)=\\frac{NN(I)}{OPT(I)}=O(\\log n)\\\\
\$\$
显然$R_(N N) = oo$.所以$N N$算法不是常数近似比的算法，不能实际应用。

=== 最小顶点覆盖问题
<最小顶点覆盖问题>
开始时初始化顶点集合$C$为空集，然后重复执行以下操作------任意选取图中的一条边$\( u \, v \)$，将这两个顶点$u$和$v$加入集合$C$中，同时从图中删除这两个顶点及其所有关联边；持续进行这样的操作直到图中所有的边都被删除为止，最终得到的集合$C$就是所求的顶点覆盖。

算法挑选的边构成图的极大匹配$M$（即不存在其他匹配$M'$满足$M subset M'$）；由于覆盖$M$中的边至少需要$\| M \|$个顶点，因此最小顶点覆盖的大小至少为$\| M \|$，而MVC算法实际得到的覆盖大小为$2 \| M \|$，由此可推导出近似比$R_(M V C) lt.eq 2$。
MVC是2-可近似算法。

设$G = \( V \, E \)$，其中顶点集$V = { u \, v }$，边集$E = { \( u \, v \) }$。近似顶点覆盖算法$A P P R O X - V E R T E X - C O V E R$返回的解只能是${ u \, v }$，而最优解为${ u }$或${ v }$，此时该算法返回顶点覆盖的规模恰为最优覆盖的两倍。

考虑以下启发式算法来解决顶点覆盖问题：重复选择度数最高的顶点，然后删除其所有关联边。举一个例子来说明这种启发式算法的近似比不为2。（提示：考虑一个二分图，左边顶点集合中的点的度数相同，右边顶点集合中的点的度数不相同。）

#strong[解答：]

构造二分图 $G = \( V \, E \)$，其中： $ V & = L union R \
L & = { l_1 \, l_2 \, l_3 \, l_4 \, l_5 } \
R & = { r_1 \, r_2 \, dots.h \, r_11 } $

边集 $E$ 包含以下边：
$
  & #scale(x: 120%, y: 120%)[{] \( l_1 \, r_1 \) \, \( l_1 \, r_3 \) \, \( l_1 \, r_4 \) \, \( l_1 \, r_6 \) \, \( l_1 \, r_7 \) \,\
  & \( l_2 \, r_1 \) \, \( l_2 \, r_2 \) \, \( l_2 \, r_4 \) \, \( l_2 \, r_6 \) \, \( l_2 \, r_8 \) \,\
  & \( l_3 \, r_1 \) \, \( l_3 \, r_2 \) \, \( l_3 \, r_3 \) \, \( l_3 \, r_5 \) \, \( l_3 \, r_9 \) \,\
  & \( l_4 \, r_1 \) \, \( l_4 \, r_2 \) \, \( l_4 \, r_3 \) \, \( l_4 \, r_5 \) \, \( l_4 \, r_10 \) \,\
  & \( l_5 \, r_1 \) \, \( l_5 \, r_2 \) \, \( l_5 \, r_3 \) \, \( l_5 \, r_4 \) \, \( l_5 \, r_11 \) #scale(x: 120%, y: 120%)[}]
$

=== 多机调度问题
<多机调度问题>
给定有穷作业集$A$和$m$台相同的机器，作业$a$的处理时间为正整数$t \( a \)$，每一项作业可以在任一台机器上处理。如何把作业分配给机器才能使完成所有作业的时间最短？即如何把$A$划分成$m$个不相交的子集$A_i$使得$max {sum_(a in A_i) t \( a \) divides i = 1 \, 2 \, dots.h.c \, m}$最小。

贪心法
G-MPS：按输入的顺序分配作业；把每一项作业分配给当前负载最小的机器；如果当前负载最小的机器有2台或2台以上，则分配给其中的任意一台（比如标号最小的一台）。

#block[
  对于多机调度问题的每一个有$m$台机器的实例$I$，贪心算法G-MPS满足：
  $ upright("G-MPS") \( I \) lt.eq (2 - 1 / m) upright("OPT") \( I \) $
  其中$upright("OPT") \( I \)$表示最优调度长度。

]
#block[
  #emph[Proof.] 首先建立两个基本事实：

  + $upright("OPT") \( I \) gt.eq 1 / m sum_(a in A) t \( a \)$
    （$m$台机器的最大负载不小于平均负载）

  + $upright("OPT") \( I \) gt.eq max_(a in A) t \( a \)$
    （最大负载不小于任一作业的处理时间）

  设机器$M_j$的负载最大，即$upright("G-MPS") \( I \) = t \( M_j \)$。令$b$是最后被分配给$M_j$的作业。根据贪心算法规则，在分配$b$时$M_j$的负载最小，因此有：
  $ t \( M_j \) - t \( b \) lt.eq 1 / m (sum_(a in A) t \( a \) - t \( b \)) $

  由此可得： $ upright("G-MPS") \( I \) & = t \( M_j \)\
  & lt.eq 1 / m (sum_(a in A) t \( a \) - t \( b \)) + t \( b \)\
  & = 1 / m sum_(a in A) t \( a \) + (1 - 1 / m) t \( b \)\
  & lt.eq upright("OPT") \( I \) + (1 - 1 / m) upright("OPT") \( I \) quad upright("（由事实2）")\
  & = (2 - 1 / m) upright("OPT") \( I \) $~◻

]
给定$m$台机器和$m \( m - 1 \) + 1$项作业，其中前$m \( m - 1 \)$项作业的处理时间都为$1$，最后一项作业的处理时间为$m$。算法方案是将前$m \( m - 1 \)$项作业平均分配给$m$台机器，每台分配$m - 1$项，最后一项任意分配给一台机器，此时$G - M P S \( I \) = 2 m - 1$。最优分配方案则是将前$m \( m - 1 \)$项作业平均分配给$m - 1$台机器，每台分配$m$项，最后一项分配给剩下的机器，此时$O P T \( I \) = m$。由此可得$G - M P S$是$2$-近似算法。

递降贪心法DG-MPS:
首先按处理时间从大到小重新排列作业（处理时间长的作业优先处理），然后运用G-MPS.

时间复杂度分析：DG-MPS增加排序时间$O \( n l o g n \)$，仍然是多项式时间.

#block[
  对于多机调度问题的每一个有$m$台机器的实例$I$，递降贪心算法DG-MPS满足：
  $ upright("DG-MPS") \( I \) lt.eq (3 / 2 - frac(1, 2 m)) upright("OPT") \( I \) $
  其中$upright("OPT") \( I \)$表示最优调度长度。

]
#block[
  #emph[Proof.]
  设作业按处理时间从大到小排列为$a_1 \, a_2 \, dots.h \, a_n$，考虑负载最大的机器$M_j$和最后分配给$M_j$的作业$a_i$，存在两种情况：

  + #strong[情况1]：$M_j$只有一个作业

    - 此时$i = 1$，即$a_i$是处理时间最大的作业

    - 显然$upright("DG-MPS") \( I \) = t \( a_1 \) = upright("OPT") \( I \)$

  + #strong[情况2]：$M_j$有至少两个作业

    - 则$i gt.eq m + 1$（因为前$m$个作业已分配给不同机器）

    - 由最优解性质可得：
      $ upright("OPT") \( I \) gt.eq t \( a_m \) + t \( a_(m + 1) \) gt.eq 2 t \( a_(m + 1) \) gt.eq 2 t \( a_i \) $

    - 对DG-MPS的负载进行分析：
      $
        upright("DG-MPS") \( I \) & = t \( M_j \) \
                                  & lt.eq 1 / m (sum_(k = 1)^n t \( a_k \) - t \( a_i \)) + t \( a_i \) \
                                  & = 1 / m sum_(k = 1)^n t \( a_k \) + (1 - 1 / m) t \( a_i \) \
                                  & lt.eq upright("OPT") \( I \) + (1 - 1 / m) dot.op 1 / 2 upright("OPT") \( I \) \
                                  & = (3 / 2 - frac(1, 2 m)) upright("OPT") \( I \)
      $

  ~◻

]
== 不可近似问题
<不可近似问题>
#block[
  对于不要求满足三角不等式的货郎问题，不存在常数近似比的近似算法，除非$P = N P$。

]
#block[
  #emph[Proof.]
  假设存在这样的近似算法$A$，其近似比$r lt.eq K$（$K$为常数）。我们将通过构造性证明这与$N P$完全问题（哈密顿回路问题）的关系。

  #heading(level: 2, numbering: none)[构造方法]
  <构造方法>
  对任意给定的图$G = chevron.l V \, E chevron.r$，构造货郎问题实例$I_G$如下：

  - 城市集合为$V$，其中$\| V \| = n$

  - 距离函数定义为：
    $ d \( u \, v \) = cases(delim: "{", 1 \, & upright("若") \( u \, v \) in E, K n \, & upright("否则")) $

  #heading(level: 2, numbering: none)[关键性质]
  <关键性质>
  + 若$G$有哈密顿回路：
    $ upright("OPT") \( I_G \) = n \, quad A \( I_G \) lt.eq r upright("OPT") \( I_G \) lt.eq K n $

  + 若$G$无哈密顿回路：
    $ upright("OPT") \( I_G \) > K n \, quad A \( I_G \) gt.eq upright("OPT") \( I_G \) > K n $

  基于算法$A$可设计如下判定算法：

  + 构造$I_G$（耗时$O \( n^2 \)$）

  + 对$I_G$运行$A$（多项式时间）

  + 若$A \( I_G \) lt.eq K n$输出\"Yes\"，否则输出\"No\"

  该算法可在多项式时间内判定哈密顿回路问题（HC）。由于HC是$N P$完全的，故$P = N P$，与普遍接受的复杂性假设矛盾。~◻

]
== 完全可近似问题
<完全可近似问题>
例如对于01背包问题： 如果用贪心算法(G-KK)，不断尝试单位价值最大的物品:

#block[
  对于0-1背包问题的任何实例$I$，贪心算法$G$和最优解$O P T \( I \)$满足：
  $ O P T \( I \) < 2 G - K K \( I \) $
  其中$K K \( I \)$表示背包的剩余容量。

]
#block[
  #emph[Proof.]
  设物品按单位重量价值$v_i / w_i$从大到小排列为$u_1 \, u_2 \, dots.h \, u_n$，$u_k$是贪心算法$G$中第一件未装入背包的物品。根据贪心策略的特性：

  $
    O P T \( I \) & < G - K K \( I \) + v_k quad upright("（最优解最多比贪心解多放入") u_k upright("的价值）") \
                  & lt.eq G - K K \( I \) + v_max quad upright("（") v_k lt.eq max_(1 lt.eq i lt.eq n) v_i upright("）") \
                  & lt.eq 2 G - K K \( I \) quad upright("（因") v_max lt.eq G upright("）")
  $

  其中关键不等式成立因为：

  - 贪心解$G$至少包含一个最大价值物品（否则可以替换）

  - $K K \( I \)$表示贪心解装入后的剩余容量

  ~◻

]
#block[
  $epsilon arrow.l 1 / k$
  将物品按$v_i / w_i$降序排列：$v_1 / w_1 gt.eq dots.h.c gt.eq v_n / w_n$
  输出$max { A_0 \( I \) \, dots.h \, A_k \( I \) }$

]
#block[
  对任意$k gt.eq 1$，PTAS算法满足：

  - 时间复杂度：$O \( k n^(k + 1) \)$

  - 近似比：$R_k = frac(O P T \( I \), A_epsilon \( I \)) < 1 + 1 / k = 1 + epsilon$

]
#block[
  #emph[Proof.] #strong[时间复杂度分析]：

  - 子集枚举量：$sum_(j = 0)^k binom(n, j) = O \( k n^k \)$

  - 每次G-KK计算：$O \( n \)$

  - 总时间：$O \( k n^(k + 1) \)$

  #strong[近似比证明]： 设最优解$X$，分两种情况：

  + 若$\| X \| lt.eq k$：算法必得$X$（因枚举所有$lt.eq k$的子集）

  + 若$\| X \| > k$：

    - 取$Y subset X$为前$k$个最大价值物品

    - 设$Z = X \\ Y = { u_(k + 1) \, dots.h \, u_r }$（保持$v_j / w_j$降序）

    - 设$u_m$为$Z$中第一个未被算法装入的物品

    - 定义$W$为算法在$u_m$前装入的非${ u_1 \, dots.h \, u_m }$物品

    关键推导：
    $
      C' & = C - sum_(j = 1)^k w_j - sum_(j = k + 1)^(m - 1) w_j\
      C'' & = C' - sum_(u_j in W) w_j < w_m quad upright("（因") u_m upright("未装入）")\
      O P T \( I \) & lt.eq sum_(j = 1)^k v_j + sum_(j = k + 1)^(m - 1) v_j + C' v_m / w_m\
      & < sum_(j = 1)^k v_j + sum_(j = k + 1)^(m - 1) v_j + sum_(u_j in W) v_j + v_m quad upright("（因") v_j / w_j gt.eq v_m / w_m upright("）")\
      & < A_epsilon \( I \) + frac(O P T \( I \), k + 1) quad upright("（因") \( k + 1 \) v_m lt.eq O P T \( I \) upright("）")\
      arrow.r.double R_k & < 1 + 1 / k = 1 + epsilon
    $

  ~◻

]
- #strong[PTAS (Polynomial-Time Approximation Scheme)]:
  对任意小正数$epsilon$，在输入规模$n$的多项式时间内找到$\( 1 + epsilon \)$-近似解。
  运行时间关于$n$的多项式，但可能关于$1 \/ epsilon$指数增长。

- #strong[FPAS/FPTAS (Fully Polynomial-Time Approximation Scheme)]:
  运行时间同时是$n$和$1 \/ epsilon$的多项式，具有实际可行性。

对于存在伪多项式时间算法的NP难问题，构造FPTAS的一般方法：

+ 设原问题实例$I$的输入值为$x_1 \, dots.h \, x_k$

+ 伪多项式算法$A$运行时间为$T \( n \, sum x_i \)$

+ 进行标度变换：$x'_i = floor.l frac(x_i, f \( epsilon \)) floor.r$

+ 得到新实例$I'$

+ 用算法$A$求解$I'$得解$S'$

+ 证明$S'$是$I$的$\( 1 + epsilon \)$-近似解

#block[
  $K arrow.l frac(C, 2 \( k + 1 \) n)$ $C' arrow.l floor.l C \/ K floor.r$
  创建新实例$I' = \( C' \, { \( s'_i \, v'_i \) }_(i = 1)^n \)$
  $S arrow.l upright("KNAPSACK") \( I' \)$ $S$

]
#strong[性质]：

- 构成算法簇：对每个$k$，$epsilon = 1 \/ k$，记为$A_epsilon$

- 时间复杂度：$Theta \( n^2 \/ epsilon \)$

#block[
  对每个整数$k > 1$，$epsilon = 1 \/ k$和任意实例$I$：
  $ upright("OPT") \( I \) < \( 1 + epsilon \) A_epsilon \( I \) $
  时间复杂度为$Theta \( n^2 \/ epsilon \)$。

]
#block[
  #emph[Proof.] #strong[时间复杂度分析]：
  $
    T \( n \) & = Theta \( n C' \/ K \) \
              & = Theta (n dot.op C / K dot.op 1 / K) \
              & = Theta (n dot.op frac(2 \( k + 1 \) n, K)) \
              & = Theta \( k n^2 \) = Theta \( n^2 \/ epsilon \)
  $

  #strong[近似比证明]： 设$I'$为标度变换后的实例：

  - $upright("OPT") \( I' \) gt.eq sum_(i in S^(*)) floor.l v_i \/ K floor.r$（$S^(*)$是最优解）

  - 有不等式链：
    $
      upright("OPT") \( I \) - K dot.op upright("OPT") \( I' \) & lt.eq K n quad upright("(最优解至多") n upright("项)") \
                     upright("OPT") \( I \) - A_epsilon \( I \) & lt.eq K n quad upright("(近似解定义)") \
                                              A_epsilon \( I \) & gt.eq upright("OPT") \( I \) - K n \
                                                                & = upright("OPT") \( I \) - frac(C, 2 \( k + 1 \))
    $

  - 假设$upright("OPT") \( I \) gt.eq C \/ 2$（否则易得最优解），则：
    $
      frac(A_epsilon \( I \), upright("OPT") \( I \)) & gt.eq 1 - frac(1, 2 \( k + 1 \) upright("OPT") \( I \) \/ C) \
                                                      & > 1 - frac(1, k + 1) = frac(k, k + 1) \
                         arrow.r.double R_(A_epsilon) & < frac(k + 1, k) = 1 + 1 / k = 1 + epsilon
    $

  ~◻

]
== 课后作业
<课后作业>
=== 独立集问题
<独立集问题>
给出一个独立集问题的近似算法，即找到最大的顶点子集，子集中顶点互不相连。并请证明或否定该近似算法的近似度是有界的。

使用贪心算法：

+ 初始化独立集 $S = nothing$。

+ 从图中选择一个度数最小的顶点 $v$，将其加入 $S$。

+ 将 $v$ 及其所有邻居从图中删除。

+ 重复步骤2-3，直到图中没有剩余顶点。

每次选择一个顶点加入 $S$ 时，最多会\"排除\" $Delta + 1$
个顶点（包括该顶点及其邻居）。因此，贪心算法得到的独立集大小至少为
$frac(O P T, Delta + 1)$，其中 $O P T$ 是最优解的大小。

=== 最大子集和问题
<最大子集和问题>
最大子集和问题：给定含有$n$个正整数的集合$S = { s_1 \, s_2 \, . . . \, s_n }$和一个正整数$C$，要求找出S的一个子集，使得它们的和最大且不超过$C$。请给出求解该问题的完全多项式近似方案。要求分析算法时间复杂度和近似比。

运用动态规划思想:

+ 设定近似参数 $epsilon in \( 0 \, 1 \)$，计算缩放因子
  $k = frac(epsilon dot.op max \( S \), n)$。

+ 对集合 $S$ 中每个元素 $s_i$，计算缩放后的值 $s'_i = ⌊s_i / k⌋$。

+ 使用动态规划求解缩放后的问题：

  - 定义 $d p \[ i \] \[ j \]$ 表示前$i$个元素能否组成和$j$

  - 初始化 $d p \[ 0 \] \[ 0 \] = upright("True")$

  - 状态转移：$d p \[ i \] \[ j \] = d p \[ i - 1 \] \[ j \] or d p \[ i - 1 \] \[ j - s'_i \]$

+ 在满足 $sum_(i in T) s'_i lt.eq ⌊C / k⌋ eq.delta J_(m a x)$
  的所有子集$T$中，利用$d p \[ n \] \[ . . \]$来找到使
  $sum_(i in T) s_i$ 最大的解。

而对于该算法的时间复杂度与近似比：

- #strong[参数缩放阶段]：

  - 计算最大值$max \( S \)$：$O \( n \)$

  - 计算缩放因子$k = frac(epsilon dot.op max \( S \), n)$：$O \( 1 \)$

  - 缩放所有元素$s'_i = ⌊s_i / k⌋$：$O \( n \)$

- #strong[动态规划阶段]：

  - 最大缩放和计算：
    $ J_max = ⌊C / k⌋ = O \( frac(n C, epsilon max \( S \)) \) $

  - 状态转移次数：
    $ O \( n dot.op J_max \) = O \( n dot.op frac(n C, epsilon max \( S \)) \) $

- #strong[总时间复杂度]：
  $ T \( n \, epsilon \) = O \( frac(n^2 C, epsilon max \( S \)) \) $
  注意到$max \( S \) lt.eq C$，因此：
  $ T \( n \, epsilon \) lt.eq O \( n^2 / epsilon \) $
  显然，这是一个完全多项式近似算法。

- #strong[缩放误差分析]：
  $
    forall s_i : med & k dot.op s'_i lt.eq s_i lt.eq k \( s'_i + 1 \) \
                     & sum_(i in T) s_i - k sum_(i in T) s'_i lt.eq n k = epsilon max \( S \)
  $

- #strong[近似比推导]：
  $ A L G gt.eq k dot.op O P T' gt.eq O P T - n k = O P T - epsilon max \( S \) $
  $ R_(A L G) & = max \( frac(A L G, O P T) \, frac(O P T, A L G) \) \
            & = frac(O P T, A L G) \
            & lt.eq frac(O P T, O P T - epsilon max \( S \)) \
            & = frac(1, 1 - frac(epsilon max \( S \), O P T)) \ $ 若$max \( S \) lt.eq O P T$，则易知$R_(A L G) lt.eq 1 + epsilon$,
  若$max \( S \) > O P T$，则对该算法进行修正，将所有满足$s_i > C$的$s_i$均删除，再次进行计算，即可转化为上一种情况。

  其中$A L G$为该算法得到的解，
  $O P T$为最优解，$O P T'$为缩放后问题的最优解

=== 无向图最大割集问题
<无向图最大割集问题>
设无向图$G = \( V \, E \)$，$V_1 union V_2 = V \, V_1 sect V_2 = nothing$。若边$\( u \, v \) in E$且$u in V_1$，则称$\( u \, v \)$为割边；否则称为非割边。求最大割集问题：任给无向图$G = \( V \, E \)$，求G的边数最多的割集。

求最大割集的局部改进算法MCUT思想如下：

初始令$V_1 = V$，$V_2 = nothing$。重复以下操作：

+ 若存在顶点$u$，在$u$关联的边中非割边数$>$割边数

  - 若$u in V_1$，则将$u$移至$V_2$

  - 若$u in V_2$，则将$u$移至$V_1$

+ 直到不存在这样的顶点时停止

最终得到的$\( V_1 \, V_2 \)$即为解。对任意实例满足：
$ O P T \( I \) lt.eq 2 dot.op M C U T \( I \) $
其中$O P T \( I \)$表示最优解的边数。

设$C$为算法得到的割边数$M C U T \( I \)$，设顶点$u$的割边与非割边数分别是$c \( u \)$和$n c \( u \)$，那么：

每条割边连接$V_1$和$V_2$，因此$sum_(u in V) c \( u \) = 2 C$。因为$c \( u \) gt.eq n c \( u \)$，所以对于每个顶点$u$，其度数$d \( u \) = c \( u \) + n c \( u \) lt.eq 2 times c \( u \)$，那么$c \( u \) gt.eq frac(d \( u \), 2)$,
所以$2 C = sum_(u in V) c \( u \) gt.eq 1 / 2 sum_(u in V) d \( u \) = \| E \|$，所以$O P T \( I \) lt.eq \| E \| lt.eq 2 C = 2 dot.op M C U T \( I \)$

=== 平面TSP问题的最小权匹配
<平面tsp问题的最小权匹配>
对TSP问题所有满足三角不等关系的实例$I$，已知有最小权匹配$\( M M \)$近似算法求解，且$M M \( I \) < 3 / 2 O P T \( I \)$，请给出具有该近似比的紧实例。

这个题肯定需要让顶点数$n$趋于无穷，使得$l e n g t h \( T \) arrow.r O P T \( I \) \, l e n g t h \( M \) arrow.r 1 / 2 O P T$即可，这里我们必须约定我们找到的最小生成树满足某些特殊的性质，使得$n$个点中度数为奇数的点的数量是接近$n$的，这样就可以使得$l e n g t h \( M \) arrow.r 1 / 2 O P T$.
而且依靠这个最小生成树得到的欧拉图，必须是能够变成哈密尔顿回路的，即不存在割点。

按照以上原则进行构造即可。

- #strong[PTAS (Polynomial-Time Approximation Scheme)]:
  对任意小正数$epsilon$，在输入规模$n$的多项式时间内找到$\( 1 + epsilon \)$-近似解。
  运行时间关于$n$的多项式，但可能关于$1 \/ epsilon$指数增长。

- #strong[FPAS/FPTAS (Fully Polynomial-Time Approximation Scheme)]:
  运行时间同时是$n$和$1 \/ epsilon$的多项式，具有实际可行性。

对于存在伪多项式时间算法的NP难问题，构造FPTAS的一般方法：

+ 设原问题实例$I$的输入值为$x_1 \, dots.h \, x_k$

+ 伪多项式算法$A$运行时间为$T \( n \, sum x_i \)$

+ 进行标度变换：$x'_i = floor.l frac(x_i, f \( epsilon \)) floor.r$

+ 得到新实例$I'$

+ 用算法$A$求解$I'$得解$S'$

+ 证明$S'$是$I$的$\( 1 + epsilon \)$-近似解

#block[
  $K arrow.l frac(C, 2 \( k + 1 \) n)$ $C' arrow.l floor.l C \/ K floor.r$
  创建新实例$I' = \( C' \, { \( s'_i \, v'_i \) }_(i = 1)^n \)$
  $S arrow.l upright("KNAPSACK") \( I' \)$ $S$

]
#strong[性质]：

- 构成算法簇：对每个$k$，$epsilon = 1 \/ k$，记为$A_epsilon$

- 时间复杂度：$Theta \( n^2 \/ epsilon \)$

#block[
  对每个整数$k > 1$，$epsilon = 1 \/ k$和任意实例$I$：
  $ upright("OPT") \( I \) < \( 1 + epsilon \) A_epsilon \( I \) $
  时间复杂度为$Theta \( n^2 \/ epsilon \)$。

]
#block[
  #emph[Proof.] #strong[时间复杂度分析]：
  $
    T \( n \) & = Theta \( n C' \/ K \) \
              & = Theta (n dot.op C / K dot.op 1 / K) \
              & = Theta (n dot.op frac(2 \( k + 1 \) n, K)) \
              & = Theta \( k n^2 \) = Theta \( n^2 \/ epsilon \)
  $

  #strong[近似比证明]： 设$I'$为标度变换后的实例：

  - $upright("OPT") \( I' \) gt.eq sum_(i in S^(*)) floor.l v_i \/ K floor.r$（$S^(*)$是最优解）

  - 有不等式链：
    $
      upright("OPT") \( I \) - K dot.op upright("OPT") \( I' \) & lt.eq K n quad upright("(最优解至多") n upright("项)") \
                     upright("OPT") \( I \) - A_epsilon \( I \) & lt.eq K n quad upright("(近似解定义)") \
                                              A_epsilon \( I \) & gt.eq upright("OPT") \( I \) - K n \
                                                                & = upright("OPT") \( I \) - frac(C, 2 \( k + 1 \))
    $

  - 假设$upright("OPT") \( I \) gt.eq C \/ 2$（否则易得最优解），则：
    $
      frac(A_epsilon \( I \), upright("OPT") \( I \)) & gt.eq 1 - frac(1, 2 \( k + 1 \) upright("OPT") \( I \) \/ C) \
                                                      & > 1 - frac(1, k + 1) = frac(k, k + 1) \
                         arrow.r.double R_(A_epsilon) & < frac(k + 1, k) = 1 + 1 / k = 1 + epsilon
    $

  ~◻

]
=== 最大团问题
<最大团问题>
给定近似参数$epsilon.alt$，假设存在一个近似比为常数$rho$的算法$A$用于求解最大团问题。对于图$G = \( V \, E \)$，设其最大团大小为$m$，我们通过以下步骤构造新的近似算法：

#block[
  计算$k = ceil.l 1 \/ log_c \( 1 + epsilon.alt \) ceil.r$
  构造图$G^(\( k \))$ 使用算法$A$在$G^(\( k \))$中找到大小为$n$的团 \
  将$G^(\( k \))$的团映射回$G$，得到团$C$ \
  $C$

]
$
                 m / n^(1 \/ k) & lt.eq c^(1 \/ k) \
           upright("令") quad k & = frac(1, log_c \( 1 + epsilon.alt \)) \
  arrow.r.double m / n^(1 \/ k) & lt.eq 1 + epsilon.alt \
      arrow.r.double n^(1 \/ k) & gt.eq frac(m, 1 + epsilon.alt)
$

$
  k & = frac(1, log_c \( 1 + epsilon.alt \)) = frac(ln c, ln \( 1 + epsilon.alt \)) \
    & gt.eq frac(ln c, epsilon.alt) quad \( upright("因为") ln \( 1 + epsilon.alt \) lt.eq epsilon.alt \)
$

因此算法$A'$满足：

- 近似比：$1 + epsilon.alt$

- 时间复杂度：关于$\| V \|$和$1 \/ epsilon.alt$的多项式

上述构造证明了最大团问题存在完全多项式时间近似模式(FPTAS)，其中：
$ upright("输出团大小") gt.eq frac(m, 1 + epsilon.alt) $
且运行时间关于输入规模和$1 \/ epsilon.alt$均为多项式级别。

=== 证明TSP是不可近似问题
<证明tsp是不可近似问题>
#block[
  #emph[反证法.]
  假设存在常数$rho gt.eq 1$，使得一般旅行商问题(TSP)存在多项式时间$rho$-近似算法$A$。我们将通过以下步骤导出矛盾：

  ==== 步骤1：问题转化
  <步骤1问题转化>
  给定哈密顿环问题实例$G = \( V \, E \)$，构造对应的TSP实例：

  - 完全图$G' = \( V \, E' \)$，其中$E' = { \( u \, v \) : u \, v in V upright("且") u eq.not v }$

  - 代价函数定义为：
    $ c \( u \, v \) = cases(delim: "{", 1 & upright("若 ") \( u \, v \) in E, rho \| V \| + 1 & upright("否则")) $

  ==== 步骤2：代价分析
  <步骤2代价分析>
  - #strong[情况1]：若$G$有哈密顿环$H$，则对应TSP回路代价：
    $ C_(upright("opt")) = sum_(\( u \, v \) in H) c \( u \, v \) = \| V \| $

  - #strong[情况2]：若$G$无哈密顿环，则任何TSP回路至少包含一条非$E$中的边，其最小代价为：
    $ C_(upright("min")) gt.eq \( rho \| V \| + 1 \) + \( \| V \| - 1 \) > rho \| V \| $

  ==== 步骤3：算法行为
  <步骤3算法行为>
  对构造的TSP实例$chevron.l G' \, c chevron.r$运行算法$A$：

  - 若$G$有哈密顿环，$A$输出回路代价$C_A lt.eq rho C_(upright("opt")) = rho \| V \|$

  - 若$G$无哈密顿环，$A$输出回路代价$C_A > rho \| V \|$

  ==== 步骤4：矛盾导出
  <步骤4矛盾导出>
  通过比较$C_A$与$rho \| V \|$可判定$G$是否存在哈密顿环。这意味着：
  $ upright("哈密顿环问题") in P $
  根据定理34.13（哈密顿环的NP完全性）和定理34.4（P=NP的充分条件），将导致$P = N P$，与前提$P eq.not N P$矛盾。~◻

]
#block[
  构造完全图$G' = \( V \, E' \)$，其中$E' = { \( u \, v \) : u \, v in V upright("且") u eq.not v }$
  定义代价函数：
  $ c \( u \, v \) = cases(delim: "{", 1 & upright("若 ") \( u \, v \) in E, rho \| V \| + 1 & upright("否则")) $
  \
  运行$rho$-近似算法$A$于$chevron.l G' \, c chevron.r$

]
#heading(level: 3, numbering: none)[理论意义]
<理论意义>
该证明揭示了：

- TSP的不可近似性直接源于其与NP完全问题的等价关系

- 近似算法存在性将导致计算复杂性层级坍塌（$P = N P$）

- 对任意$rho gt.eq 1$的推广通过代价函数的伸缩性实现

=== 瓶颈旅行商问题
<瓶颈旅行商问题>
瓶颈旅行商问题 (bottleneck traveling-salesman problem)
要求找到一条回路，满足该回路中代价最大的边的代价是所有回路中代价最大的边的代价中最小的。假设代价函数满足三角形不等式，证明：该问题有一个近似比为
3 的多项式时间近似算法。

给定无向完全图$G = \( V \, E \)$，根据思考题21-4的结论，可以在关于$\| V \|$和$\| E \|$的线性时间内求出一棵瓶颈生成树$T$。因为$G$是完全图，根据练习题34.2-11的结论，一定能由$T$在关于$\| V \|$和$\| E \|$的多项式时间内构造出一个哈密顿环$H$，且$H$上任意两个连续顶点$u$和$v$间在$T$上的距离不超过3条边。设$B_T$表示瓶颈生成树中代价最高的边。

#block[
  #emph[近似比证明.] 根据三角形不等式（如图35.2-4所示）：
  $
    c \( v_1^(\( 1 \)) \, v_2^(\( 2 \)) \) & lt.eq c \( v_1^(\( 1 \)) \, v_2^(\( 1 \)) \) + c \( v_2^(\( 1 \)) \, v_2^(\( 2 \)) \)\
    & lt.eq c \( v_1^(\( 1 \)) \, u \) + c \( u \, v_2^(\( 1 \)) \) + c \( v_2^(\( 1 \)) \, v_2^(\( 2 \)) \)\
    & lt.eq 3 c \( B_T \)
  $
  因此对任意边$\( u \, v \) in H$，有$c \( u \, v \) lt.eq 3 c \( B_T \)$。

  设$H$中代价最大的边为$B_H$，则： $ c \( B_H \) lt.eq 3 c \( B_T \) $

  设最优瓶颈回路$H^(*)$中代价最大的边为$B_H^(*)$，将其移除后得到生成树。根据瓶颈生成树的定义：
  $ c \( B_T \) lt.eq c \( B_H^(*) \) $

  联立(1)(2)式可得： $ c \( B_H \) lt.eq 3 c \( B_H^(*) \) $~◻

]
=== 最优回路不会自我交叉
<最优回路不会自我交叉>
假设旅行商问题的一个实例的所有顶点是一组平面上的点，并且代价$c \( u \, v \)$是点$u$和$v$之间的欧氏距离。证明：一条最优回路不会自我交叉。

采用反证法，假设存在一条最优回路存在一个自我交叉，如图35.2-5所示，设$\( v_1 \, v_2 \)$和$\( v_3 \, v_4 \)$交叉位于$x$，有
$ c \( v_1 \, v_2 \) + c \( v_3 \, v_4 \) = c \( v_1 \, x \) + c \( v_2 \, x \) + c \( v_3 \, x \) + c \( v_4 \, x \) $
因为所有顶点都位于欧式平面上且代价$c \( u \, v \)$是点$u$和$v$之间的欧氏距离。所以$c$满足三角形不等式，有$c \( v_1 \, x \) + c \( v_3 \, x \) > c \( v_1 \, v_3 \)$且$c \( v_2 \, x \) + c \( v_4 \, x \) > c \( v_2 \, v_4 \)$。代入前面的等式，有$c \( v_1 \, v_2 \) + c \( v_3 \, v_4 \) > c \( v_1 \, v_3 \) + c \( v_2 \, v_4 \)$，用边$\( v_1 \, v_3 \)$和$\( v_2 \, v_4 \)$替换原回路中的$\( v_1 \, v_2 \)$和$\( v_3 \, v_4 \)$得到一个代价更小的回路，与原回路是最优回路相矛盾。因此，一条最优回路不会自我交叉。证明完毕。

=== TSP不可近似性
<tsp不可近似性>
证明对于任意常数$c gt.eq 0$，一般旅行商问题不存在具有近似比为$\| V \|^c$的多项式时间的近似算法。

证明：采用反证法。假设对于某个常数$c gt.eq 0$，一般旅行商问题存在近似比为$\| V \|^c$的多项式时间算法$A$。我们将说明如何使用$A$来在多项式时间内求解哈密顿环问题的一个实例。根据定理34.13，哈密顿环问题是NP完全的，根据定理34.4，若哈密顿环问题存在一个多项式时间算法，则$P = N P$。

设$G = \( V \, E \)$是哈密顿环问题的一个实例，使用假想的近似算法$A$来检测$G$是否包含一个哈密顿环。按照如下方法将$G$转化为旅行商问题的一个实例，设$G' = \( V \, E' \)$为关于$V$的完全图，即$E' = { \( u \, v \) : u \, v in V upright(" and ") u eq.not v }$。其代价函数为：

$c \( u \, v \) = cases(delim: "{", 1 & upright("if ") \( u \, v \) in E \,, \| V \|^(c + 1) + 1 & upright("otherwise."))$

可以在关于$\| V \|$和$\| E \|$的多项式时间内构造出$G'$和$c$。

现在考虑旅行商问题的一个实例$chevron.l G' \, c chevron.r$。若$G$中存在一个哈密顿环$H$，则$c$赋予$H$中每条边的代价为1，$H$的代价为$\| V \|$，$chevron.l G' \, c chevron.r$中有一条回路代价为$\| V \|$。若$G$中不存在一个哈密顿环，则$G'$中的回路必须包含不属于$E$的边，该回路的代价至少为$\( \| V \|^(c + 1) + 1 \) + \( \| V \| - 1 \) = \| V \|^(c + 1) + \| V \| = \| V \|^c \( \| V \| + 1 \) > \| V \|^c dot.op \| V \|$。即该回路不是$G$中的一个哈密顿环的因子超过$\| V \|^c$。

假设我们用近似算法$A$来求解旅行商问题$chevron.l G' \, c chevron.r$。因为$A$保证能够返回的回路的代价不超过最优回路代价的$\| V \|^c$倍。若$G$中包含一个哈密顿环，则$A$返回一个满足上述要求的回路。若$G$中不包含一个哈密顿环，则$A$返回一个代价大于$\| V \|^(c + 1)$的回路。因此，可以使用$A$在多项式时间内求解哈密顿环问题。
