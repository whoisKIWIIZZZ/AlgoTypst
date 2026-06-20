#import "@local/ysz_tools:0.1.0": *

= chapter11: 近似算法
<chapter11-近似算法>

== 导入
<导入>

=== 组合优化问题
<组合优化问题>

#definition[组合优化问题][
  组合优化问题 $Pi$ 不是最小化问题就是最大化问题。它由三个部分组成：
  + 一个实例集合 $D_Pi$；
  + 对于每个实例 $I in D_Pi$，存在 $I$ 的一个候选解的有限集合 $S_Pi(I)$；
  + 实例 $I in D_Pi$ 的每个解 $sigma in S_Pi(I)$，存在一个值 $f_Pi(sigma)$，称为 $sigma$ 的解值。

  - 如果 $Pi$ 是最小化问题，那么实例 $I in D_Pi$ 的最优解 $sigma^*$ 满足：
    $ forall sigma in S_Pi(I),; f_Pi(sigma^*) lt.eq f_Pi(sigma) $
  - 最大化问题的最优解类似定义：
    $ forall sigma in S_Pi(I),; f_Pi(sigma^*) gt.eq f_Pi(sigma) $
  - 最优解值记为 $"OPT"(I) = f_Pi(sigma^*)$。
]

=== 近似算法
<近似算法>

#definition[近似算法][
  最优化问题 $Pi$ 的一个近似算法 $A$ 是一个 #strong[多项式时间] 算法，给定一个实例 $I in D_Pi$，算法输出某个解 $sigma in S_Pi(I)$。算法 $A$ 得到的解也称为近似解，值 $f_Pi(sigma)$ 记为 $A(I)$。

  数学表达：
  - 问题实例：$I in D_Pi$
  - 可行解集：$S_Pi(I)$
  - 近似解：$sigma in S_Pi(I)$
  - 解值表示：$A(I) = f_Pi(sigma)$
]


=== 差界（绝对性能保证）
<差界>

#definition[差界（绝对性能保证）][
  对于问题的所有实例 $I$，希望近似算法 $A$ 满足：
  $ || A(I) - "OPT"(I) || lt.eq K quad (K "为常数") $

  若对每个实例 $I$ 都有 $"OPT"(I) - K lt.eq A(I) lt.eq "OPT"(I) + K$，则称算法 $A$ 具有 #strong[有界误差] 或 #strong[差界] $K$。这也称为近似算法的 #strong[绝对性能保证]（absolute performance guarantee）。
]

适用于绝对误差敏感的场景（如资源分配问题中固定容量的偏差）。只有很少的 NP 困难问题已知差界。

=== 相对性能界（近似比）
<相对性能界>

#definition[近似度][
  设 $A$ 是求解优化问题 $Pi$ 的近似算法，$I$ 是 $Pi$ 的实例，按范围分为三种近似度：

  + #strong[实例近似度] $eta = R_A(I) = max(frac(A(I), "OPT"(I)), frac("OPT"(I), A(I))) gt.eq 1$，表示解 $A(I)$ 在实例 $I$ 上的近似比。
  + #strong[绝对近似度] $R_A = sup_(I in D_Pi) eta$，即 $R_A = inf{ r gt.eq 1 | eta lt.eq r, forall I in D_Pi }$，表示算法在所有实例上的最坏情况近似度。
  + #strong[渐进近似度] $R_A^oo = limsup_(||I|| arrow.r oo) eta$，即 $R_A^oo = inf{ r gt.eq 1 | exists N, eta lt.eq r, forall I in D_Pi, || I || gt.eq N }$，表示算法在足够大实例上的近似度。
]

#definition[近似比 $rho(n)$][
  近似算法 $A$ 在输入规模 $n$ 上的 #strong[近似比] $rho(n)$ 满足：对所有规模为 $n$ 的实例 $I$，
  $ eta lt.eq rho(n) $。
  即 $rho(n) = sup{ R_A(I) : ||I|| = n }$。$rho(n)$ 给出了算法在规模 $n$ 上的最坏情况近似度保证。$R_A = sup_n rho(n)$。
]

#definition[相对误差 $epsilon(n)$][
  若问题的输入规模为 $n$，存在一个函数 $epsilon(n)$ 使得对所有规模 $n$ 的实例 $I$ 成立：
  $ frac(|A(I) - "OPT"(I)|, "OPT"(I)) lt.eq epsilon(n) $。
  $epsilon(n)$ 称为近似算法的相对误差界，且有 $epsilon(n) lt.eq rho(n) - 1$。
]
=== 近似方案
<近似方案>

#definition[近似方案][
1.
  最优化问题的 #strong[近似方案] 是算法簇 ${ A_epsilon }_(epsilon > 0)$，满足 $ R_(A_epsilon) lt.eq 1 + epsilon $近似方案是近似度收敛于 1 的一系列算法。可视为算法 $A$，输入实例 $I$ 和误差界 $epsilon$，满足 $ R_A(I, epsilon) lt.eq 1 + epsilon $


2. 多项式近似方案（PTAS）
  近似方案 ${ A_epsilon }_(epsilon > 0)$ 中，每个 $A_epsilon$ 在 $|| I ||$ 的多项式时间内运行。注意：PTAS 的运行时间对 $|| I ||$ 是多项式，但对 $1/epsilon$ 可能非多项式。


3. 完全多项式近似方案（FPTAS）
  近似方案 ${ A_epsilon }_(epsilon > 0)$，每个 $A_epsilon$ 在 $|| I ||$ 和 $1/epsilon$ 的多项式时间内运行。
]

#definition[伪多项式时间算法][
  在 $L$ 的多项式时间内运行的算法，其中 $L$ 是输入实例的最大数值。示例：0/1 背包问题的动态规划算法（运行时间 $O(n C)$）是伪多项式时间算法。注：若算法在 $log L$ 的多项式时间内运行，则是严格多项式时间算法。
]

FPTAS 构造方法：对存在伪多项式时间算法 $A$ 的 NP 难问题：
+ 对实例 $I$ 的数值进行标度变换和舍入，得到 $I'$
+ 将 $A$ 应用于 $I'$ 得到近似解

#figure(
  align(center)[#table(
    columns: 4,
    align: (center, center, center, center),
    table.header([#strong[类型]], [#strong[时间复杂度]], [#strong[解质量]], [#strong[典型问题]]),
    table.hline(),
    [PTAS], [$O(n^(f(1/epsilon)))$], [$(1+epsilon)$-近似], [欧几里得 TSP],
    [FPTAS], [$O((1/epsilon)^k n^c)$], [$(1+epsilon)$-近似], [0-1 背包],
    [伪多项式算法], [$O(N^k n^c)$], [可能为精确解], [子集和问题],
  )],
  caption: [#strong[近似算法对比]],
  kind: table,
)

=== 可近似性分类
<可近似性分类>

#definition[完全可近似的（Fully Approximable）][
  对任意小的 $epsilon > 0$，存在 $(1+epsilon)$-近似算法。典型问题：0/1 背包问题。
]

#definition[可近似的（Approximable）][
  存在具有常数比的近似算法（如 2-近似）。典型问题：最小顶点覆盖问题、多机调度问题。
]

#definition[不可近似的（Inapproximable）][
  除非 P=NP，否则不存在具有常数比的近似算法。典型问题：货郎问题（一般 TSP）。
]

== 可近似算法举例
<可近似算法举例>

=== 装箱问题（近似比分析）
<装箱问题-分析>

会有四种启发式方法：最先匹配（"FF"，分配第一个能装的箱子），最佳匹配（"BF"，分配能装的箱子里面剩余空间最小的），递减最先匹配（"FFD"），递减最佳匹配（"BFD"）。下面我们对 "FF" 进行近似度分析：

假定：箱子容量为 1 个单位体积，物品大小 $s_i lt.eq 1$（$i = 1, 2, dots, n$）。

定义：
- $"FF"(I)$ 表示在实例 $I$ 下，使用 "FF" 算法装入物品时所用的箱子数目
- $"OPT"(I)$ 表示最优装入时所用的箱子数目

"FF" 装箱规则说明：
- 根据 "FF" 装箱规则，#strong[至多有一个非空箱子] 所装的物品体积 $lt.eq 1/2$。
- 若存在两个这样的箱子 $b_i, b_j$（$i lt j$），由于它们装的物品体积均 $lt.eq 1/2$，根据算法规则，$b_j$ 中的物品应被装入 $b_i$ 而非新箱子。

#block[
  给定若干个物品，判断它们是否可由两个箱子装下是 NP-完全的。
]

#block[
  #emph[Proof.] 可由划分问题（Partition problem）规约。划分问题是 Karp 的 21 个 NP-完全问题之一，该问题表述为：给定若干个正整数，问可否将其划分成和相等的两个部分；换言之，给定 $c_1, c_2, dots, c_n in bb(Z)^+$，划分问题问是否存在一个 $S subset.eq { 1, 2, dots, n }$ 使得
  $ sum_(i in S) c_i = sum_(i in.not S) c_i $

  根据一个划分问题实例，我们可以构造一个装箱问题，令物品的尺寸为：
  $ a_i = frac(2 c_i, sum_(j = 1)^n c_j), quad i = 1, 2, dots, n $
  同时我们假设这些 $a_i in (0, 1]$。由于 $sum_(i = 1)^n a_i = 2$，如果这些物品能用两个箱子装下，那么这两个箱子都正好装满，这也同时解答了划分问题。这样我们就把一个已知的 NP-完全问题规约为了两个箱子的装箱问题。而显然一个给定的装箱问题的解可在多项式时间内验证，因此该问题是 NP-完全的。 ~$square$
]

#remark[
  #strong[核心思路]：要证明问题 $L$ 是 NP-完全的，只需证明：
  - 存在性：已知的某个 NP-完全问题（如划分问题）可规约到 $L$
  - 无关性：不要求 $L$ 的所有实例都满足某种特性，只需特定构造的实例能覆盖原问题的解空间
]

我们之前衡量近似算法采用的是绝对近似比，定义为最坏情况下算法的求解值与问题的最优值之间的比率。对任意实例 $I$，用 $A(I)$ 表示针对实例 $I$ 运行算法 $A$ 后所用箱子数；$"OPT"(I)$ 表示装完实例 $I$ 中所有物品所用的最少箱子数。若存在常数 $alpha gt.eq 1$，对任意实例 $I$ 有：
$ A(I) lt.eq alpha dot.op "OPT"(I) $
则算法 $A$ 的近似比至多是 $alpha$。

  除非 $"P" = "NP"$，否则装箱问题不存在多项式时间算法具有小于 $3/2$ 的绝对近似比。

  #emph[证明（反证法）.] 假设存在近似比小于 $3/2$ 的多项式时间近似算法 $A$，分类讨论：

  - 当 $"OPT"(I) = 2$ 时：
    $ A(I) lt 3/2 times 2 = 3 arrow.r.double.long A(I) = 2 = "OPT"(I) $
  - 当 $"OPT"(I) gt.eq 3$ 时：$ A(I) gt.eq 3 $

  此时算法 $A$ 可精确判定"是否能用两个箱子装下"的问题，而该问题是 #emph[NP-完全的]。若 $"P" != "NP"$，则导致矛盾。~$square$


#remark[
  虽然 $"OPT"(I) = 2$ 的情况直接揭示了矛盾的核心（算法 $A$ 被迫精确求解 NP-完全问题），但必须验证 $"OPT"(I) gt.eq 3$ 时的行为，才能确保反证假设的全局一致性。这是复杂性理论证明中"规约+反证"方法的严谨性体现。
]

#definition[渐进近似比（AAR）][
  对任意常数 $alpha gt.eq 1$，任意实例 $I$，若存在常数 $k$ 满足：
  $ A(I) lt.eq alpha dot.op "OPT"(I) + k quad ("AAR") $
  则称所有满足上式的 $alpha$ 的下确界为算法 $A$ 的 #strong[渐进近似比]。其中：

  - $alpha$ 决定当 $"OPT"(I)$ 充分大时 $A(I)$ 与 $"OPT"(I)$ 的比值
  - $k$ 可以是：
    - 固定常数，或
    - $o("OPT"(I))$（满足 $lim_("OPT"(I) arrow.r oo) frac(k, "OPT"(I)) = 0$）
  - 当 $k = 0$ 时，渐进近似比退化为 #strong[绝对近似比]
]


  对于任意的实例 $I$，有：
  $"FF"(I) lt.eq frac(17, 10) "OPT"(I) + frac(4, 5) $（$"BF"$ 同为 $frac(17, 10)$）


后续再做展开：#link("https://zhuanlan.zhihu.com/p/685478438")

#block[
  对于任意的实例 $I$，有：
  $"FFD"(I) lt.eq frac(11, 9) "OPT"(I) + 4 $（$"BFD"$ 同为 $frac(11, 9)$）
]


=== ETSP 问题（欧几里得 TSP）
<etsp问题>

#problem[欧几里得 TSP][
  给定一个平面上 $n$ 个点的集合 $S$，找出一个在这些点上的最短长度的游程 $t$。这里一个游程是恰好访问每个点一次的一条回路。

  ETSP 问题是 TSP 问题的特殊情况，点之间的距离是欧式距离，满足三角不等关系。
]

==== 最近邻法（NN）

#algorithm[最近邻法][
  *输入*：平面上的 $n$ 个点\
  *输出*：一条近似最短回路

  采用贪心法：设 $p_1$ 是任意一个起始点，下一个访问距离 $p_1$ 最近的点，比如 $p_2$，再继续访问距离 $p_2$ 最近的点，直到回到 $p_1$。
]

  对于 ETSP 问题所有满足三角不等式的 $n$ 个城市的实例 $I$，有：
  $"NN"(I) lt.eq frac(1, 2) (ceil.l log_2 n ceil.r + 1) "OPT"(I) $。
  而且，对于每一个充分大的 $n$，存在满足三角不等式的 $n$ 个城市的实例 $I$ 使得：
  $"NN"(I) gt frac(1, 3) (log_2 (n+1) + frac(4, 3)) "OPT"(I) $。


很明显这里对于 "NN" 的近似比 $R_("NN")(I) = O(log n)$。$R_("NN") = infinity$，所以 "NN" 算法不是常数近似比的算法，不能实际应用。

=== 最小顶点覆盖问题
<最小顶点覆盖问题>

#problem[最小顶点覆盖][
  给定无向图 $G = (V, E)$，找一个最小的顶点集合 $C subset.eq V$，使得每条边至少有一个端点在 $C$ 中。
]

==== APPROX-VERTEX-COVER 算法

#algorithm[APPROX-VERTEX-COVER][
  *输入*：无向图 $G = (V, E)$
  *输出*：顶点覆盖 $C$

  开始时初始化顶点集合 $C$ 为空集，然后重复执行以下操作——任意选取图中的一条边 $(u, v)$，将这两个顶点 $u$ 和 $v$ 加入集合 $C$ 中，同时从图中删除这两个顶点及其所有关联边；持续进行这样的操作直到图中所有的边都被删除为止，最终得到的集合 $C$ 就是所求的顶点覆盖。
]

算法挑选的边构成图的极大匹配 $M$（即不存在其他匹配 $M'$ 满足 $M subset M'$）；由于覆盖 $M$ 中的边至少需要 $||M||$ 个顶点，因此最小顶点覆盖的大小至少为 $||M||$，而 APPROX-VERTEX-COVER 算法实际得到的覆盖大小为 $2||M||$，由此可推导出近似比 $R_("MVC") lt.eq 2$。该算法是 2-可近似算法。

设 $G = (V, E)$，其中顶点集 $V = { u, v }$，边集 $E = { (u,v) }$。近似顶点覆盖算法 "APPROX-VERTEX-COVER" 返回的解只能是 ${ u, v }$，而最优解为 ${ u }$ 或 ${ v }$，此时该算法返回顶点覆盖的规模恰为最优覆盖的两倍。

考虑以下启发式算法来解决顶点覆盖问题：重复选择度数最高的顶点，然后删除其所有关联边。举一个例子来说明这种启发式算法的近似比不为 2。（提示：考虑一个二分图，左边顶点集合中的点的度数相同，右边顶点集合中的点的度数不相同。）

#strong[解答：] 构造二分图 $G = (V, E)$，其中：
$ V = L union R,quad L = { l_1, l_2, l_3, l_4, l_5 },quad R = { r_1, r_2, dots, r_11 } $

边集 $E$ 包含以下边：
$
  & { (l_1,r_1), (l_1,r_3), (l_1,r_4), (l_1,r_6), (l_1,r_7), \
  &   (l_2,r_1), (l_2,r_2), (l_2,r_4), (l_2,r_6), (l_2,r_8), \
  &   (l_3,r_1), (l_3,r_2), (l_3,r_3), (l_3,r_5), (l_3,r_9), \
  &   (l_4,r_1), (l_4,r_2), (l_4,r_3), (l_4,r_5), (l_4,r_10), \
  &   (l_5,r_1), (l_5,r_2), (l_5,r_3), (l_5,r_4), (l_5,r_11) }
$

=== 多机调度问题
<多机调度问题>

#problem[多机调度][
  给定有穷作业集 $A$ 和 $m$ 台相同的机器，作业 $a$ 的处理时间为正整数 $t(a)$，每一项作业可以在任一台机器上处理。如何把作业分配给机器才能使完成所有作业的时间最短？即如何把 $A$ 划分成 $m$ 个不相交的子集 $A_i$ 使得 $max{ sum_(a in A_i) t(a) | i = 1,2,dots,m }$ 最小。
]

==== G-MPS（贪心法）

#algorithm[G-MPS][
  *输入*：作业集 $A$，$m$ 台机器\
  *输出*：作业分配方案

  按输入的顺序分配作业；把每一项作业分配给当前负载最小的机器；如果当前负载最小的机器有 2 台或 2 台以上，则分配给其中的任意一台（比如标号最小的一台）。
]

#block[
  对于多机调度问题的每一个有 $m$ 台机器的实例 $I$，贪心算法 $"G-MPS"$ 满足：
  $"G-MPS"(I) lt.eq (2 - frac(1, m)) "OPT"(I) $
  其中 $"OPT"(I)$ 表示最优调度长度。
]

#block[
  #emph[Proof.] 首先建立两个基本事实：

  + $"OPT"(I) gt.eq frac(1, m) sum_(a in A) t(a)$（$m$ 台机器的最大负载不小于平均负载）
  + $"OPT"(I) gt.eq max_(a in A) t(a)$（最大负载不小于任一作业的处理时间）

  设机器 $M_j$ 的负载最大，即 $"G-MPS"(I) = t(M_j)$。令 $b$ 是最后被分配给 $M_j$ 的作业。根据贪心算法规则，在分配 $b$ 时 $M_j$ 的负载最小，因此有：
  $ t(M_j) - t(b) lt.eq frac(1, m) (sum_(a in A) t(a) - t(b)) $

  由此可得：
  $"G-MPS"(I) = t(M_j) lt.eq frac(1, m) (sum_(a in A) t(a) - t(b)) + t(b) $
  $ = frac(1, m) sum_(a in A) t(a) + (1 - frac(1, m)) t(b) $
  $ lt.eq "OPT"(I) + (1 - frac(1, m)) "OPT"(I) $（由事实 2）
  $ = (2 - frac(1, m)) "OPT"(I) $ ~$square$
]

#strong[紧例分析]：给定 $m$ 台机器和 $m(m-1)+1$ 项作业，其中前 $m(m-1)$ 项作业的处理时间都为 $1$，最后一项作业的处理时间为 $m$。算法方案是将前 $m(m-1)$ 项作业平均分配给 $m$ 台机器，每台分配 $m-1$ 项，最后一项任意分配给一台机器，此时 $"G-MPS"(I) = 2m - 1$。最优分配方案则是将前 $m(m-1)$ 项作业平均分配给 $m-1$ 台机器，每台分配 $m$ 项，最后一项分配给剩下的机器，此时 $"OPT"(I) = m$。由此可得 G-MPS 是 2-近似算法。

==== DG-MPS（递降贪心法）

#strong[思路]：首先按处理时间从大到小重新排列作业（处理时间长的作业优先处理），然后运用 G-MPS。

#algorithm[DG-MPS][
  *输入*：作业集 $A$，$m$ 台机器
  *输出*：作业分配方案

  + 将作业按处理时间从大到小排序
  + 按此顺序，将每个作业分配给当前负载最小的机器
]

时间复杂度分析：DG-MPS 增加排序时间 $O(n log n)$，仍然是多项式时间。

对于多机调度问题的每一个有 $m$ 台机器的实例 $I$，递降贪心算法 $"DG-MPS"$ 满足：
$"DG-MPS"(I) lt.eq (frac(3, 2) - frac(1, 2m)) "OPT"(I) $
  其中 $"OPT"(I)$ 表示最优调度长度。



#emph[Proof.] 设作业按处理时间从大到小排列为 $a_1, a_2, dots, a_n$，考虑负载最大的机器 $M_j$ 和最后分配给 $M_j$ 的作业 $a_i$，存在两种情况：

+ #strong[情况 1]：$M_j$ 只有一个作业
  - 此时 $i = 1$，即 $a_i$ 是处理时间最大的作业
  - 显然 $"DG-MPS"(I) = t(a_1) = "OPT"(I)$

+ #strong[情况 2]：$M_j$ 有至少两个作业
  - 则 $i gt.eq m+1$（因为前 $m$ 个作业已分配给不同机器）
  - 由最优解性质可得：
    $"OPT"(I) gt.eq t(a_m) + t(a_(m+1)) gt.eq 2 t(a_(m+1)) gt.eq 2 t(a_i) $
  - 对 DG-MPS 的负载进行分析：
    $"DG-MPS"(I) = t(M_j) lt.eq frac(1, m) (sum_(k=1)^n t(a_k) - t(a_i)) + t(a_i) $
    $ = frac(1, m) sum_(k=1)^n t(a_k) + (1 - frac(1, m)) t(a_i) $
    $ lt.eq "OPT"(I) + (1 - frac(1, m)) dot.op frac(1, 2) "OPT"(I) $
    $ = (frac(3, 2) - frac(1, 2m)) "OPT"(I) $ ~$square$


== 不可近似问题
<不可近似问题>

=== 一般 TSP（无三角不等式）
<一般TSP-不可近似>

对于不要求满足三角不等式的货郎问题，不存在常数近似比的近似算法，除非 $"P" = "NP"$。


  #emph[Proof.] 假设存在这样的近似算法 $A$，其近似比 $r lt.eq K$（$K$ 为常数）。我们将通过构造性证明这与 NP 完全问题（哈密顿回路问题）的关系。

  #strong[构造方法]：对任意给定的图 $G = ⟨ V, E ⟩$，构造货郎问题实例 $I_G$ 如下：
  - 城市集合为 $V$，其中 $||V|| = n$
  - 距离函数定义为：
    $ d(u, v) = cases(1, "若" (u,v) in E, K n, "否则") $

  #strong[关键性质]：
  + 若 $G$ 有哈密顿回路：
    $"OPT"(I_G) = n,quad A(I_G) lt.eq r "OPT"(I_G) lt.eq K n $
  + 若 $G$ 无哈密顿回路：
    $"OPT"(I_G) gt K n,quad A(I_G) gt.eq "OPT"(I_G) gt K n $

  基于算法 $A$ 可设计如下判定算法：
  + 构造 $I_G$（耗时 $O(n^2)$）
  + 对 $I_G$ 运行 $A$（多项式时间）
  + 若 $A(I_G) lt.eq K n$ 输出"Yes"，否则输出"No"

  该算法可在多项式时间内判定哈密顿回路问题（HC）。由于 HC 是 NP 完全的，故 $"P" = "NP"$，与普遍接受的复杂性假设矛盾。~$square$


==== TSP 不可近似性的推广
<TSP不可近似-推广>

对于任意常数 $c gt.eq 0$，一般旅行商问题不存在具有近似比为 $||V||^c$ 的多项式时间的近似算法。

  #emph[证明（反证法）.] 假设对于某个常数 $c gt.eq 0$，一般旅行商问题存在近似比为 $||V||^c$ 的多项式时间算法 $A$。我们将说明如何使用 $A$ 来在多项式时间内求解哈密顿环问题的一个实例。

  设 $G = (V, E)$ 是哈密顿环问题的一个实例。按如下方法将 $G$ 转化为旅行商问题的一个实例：设 $G' = (V, E')$ 为关于 $V$ 的完全图，其代价函数为：
  $ c(u, v) = cases(1, "if " (u,v) in E, ||V||^(c+1) + 1, "otherwise.") $

  若 $G$ 中存在一个哈密顿环 $H$，则 $H$ 的代价为 $||V||$；若 $G$ 中不存在一个哈密顿环，则任何回路的代价至少为 $||V||^(c+1) + ||V|| gt ||V||^c dot.op ||V||$。

  因为 $A$ 保证返回的回路的代价不超过最优回路代价的 $||V||^c$ 倍，通过比较 $A(I)$ 与 $||V||^(c+1)$ 即可判定哈密顿环问题。这将导致 $"P" = "NP"$，矛盾。~$square$


==== 瓶颈 TSP（含三角不等式）
<瓶颈TSP>

瓶颈旅行商问题（bottleneck traveling-salesman problem）要求找到一条回路，满足该回路中代价最大的边的代价是所有回路中代价最大的边的代价中最小的。假设代价函数满足三角形不等式，证明：该问题有一个近似比为 3 的多项式时间近似算法。

给定无向完全图 $G = (V, E)$，可以在关于 $||V||$ 和 $||E||$ 的线性时间内求出一棵瓶颈生成树 $T$。因为 $G$ 是完全图，一定能由 $T$ 在关于 $||V||$ 和 $||E||$ 的多项式时间内构造出一个哈密顿环 $H$，且 $H$ 上任意两个连续顶点 $u$ 和 $v$ 间在 $T$ 上的距离不超过 3 条边。设 $B_T$ 表示瓶颈生成树中代价最高的边。

  #emph[近似比证明.] 根据三角形不等式：
  $
    c(v_1^((1)), v_2^((2))) & lt.eq c(v_1^((1)), v_2^((1))) + c(v_2^((1)), v_2^((2))) \
    & lt.eq c(v_1^((1)), u) + c(u, v_2^((1))) + c(v_2^((1)), v_2^((2))) \
    & lt.eq 3 c(B_T)
  $
  因此对任意边 $(u,v) in H$，有 $c(u,v) lt.eq 3 c(B_T)$。

  设 $H$ 中代价最大的边为 $B_H$，则 $c(B_H) lt.eq 3 c(B_T)$。

  设最优瓶颈回路 $H^*$ 中代价最大的边为 $B_H^*$，将其移除后得到生成树。根据瓶颈生成树的定义：
  $ c(B_T) lt.eq c(B_H^*) $

  联立两式可得：$c(B_H) lt.eq 3 c(B_H^*)$。~$square$


==== 欧氏 TSP 最优回路不自我交叉
<最优回路不自我交叉>

假设旅行商问题的一个实例的所有顶点是一组平面上的点，并且代价 $c(u,v)$ 是点 $u$ 和 $v$ 之间的欧氏距离。证明：一条最优回路不会自我交叉。

  #emph[证明（反证法）.] 假设存在一条最优回路存在一个自我交叉，设 $(v_1,v_2)$ 和 $(v_3,v_4)$ 交叉位于 $x$，有
  $ c(v_1,v_2) + c(v_3,v_4) = c(v_1,x) + c(v_2,x) + c(v_3,x) + c(v_4,x) $。

  因为所有顶点都位于欧式平面上且代价 $c(u,v)$ 是点 $u$ 和 $v$ 之间的欧氏距离，所以 $c$ 满足三角形不等式，有 $c(v_1,x) + c(v_3,x) gt c(v_1,v_3)$ 且 $c(v_2,x) + c(v_4,x) gt c(v_2,v_4)$。代入前面的等式，有 $c(v_1,v_2) + c(v_3,v_4) gt c(v_1,v_3) + c(v_2,v_4)$，用边 $(v_1,v_3)$ 和 $(v_2,v_4)$ 替换原回路中的 $(v_1,v_2)$ 和 $(v_3,v_4)$ 得到一个代价更小的回路，与原回路是最优回路相矛盾。~$square$


== 完全可近似问题
<完全可近似问题>

=== 0-1 背包问题 — 贪心算法 G-KK
<01背包-GKK>

#problem[0-1背包][
  有 $n$ 个重量分别为 ${ w_1, w_2, dots, w_n }$ 的物品，价值分别为 ${ v_1, v_2, dots, v_n }$，给定一个容量为 $W$ 的背包，每个物品要么选中要么不选中，要求选中的物品重量和不超过 $W$ 且总价值最大。
]

==== G-KK 贪心算法

#algorithm[G-KK][
  *输入*：物品集合，背包容量 $W$
  *输出*：装入背包的物品集合

  按单位价值 $v_i / w_i$ 从大到小排序，依次尝试装入背包。
]

  对于 0-1 背包问题的任何实例 $I$，贪心算法 $G$ 和最优解 $"OPT"(I)$ 满足：
  $"OPT"(I) lt 2 "G-KK"(I) $
  其中 $"KK"(I)$ 表示背包的剩余容量。


  #emph[Proof.] 设物品按单位重量价值 $v_i/w_i$ 从大到小排列为 $u_1, u_2, dots, u_n$，$u_k$ 是贪心算法 $G$ 中第一件未装入背包的物品。根据贪心策略的特性：

  $
    "OPT"(I) & lt "G-KK"(I) + v_k quad ("最优解最多比贪心解多放入 " u_k " 的价值") \
           & lt.eq "G-KK"(I) + v_max quad ("因 " v_k lt.eq max_(1 lt.eq i lt.eq n) v_i) \
           & lt.eq 2 "G-KK"(I) quad ("因 " v_max lt.eq G)
  $

  其中关键不等式成立因为：
  - 贪心解 $G$ 至少包含一个最大价值物品（否则可以替换）
  - $"KK"(I)$ 表示贪心解装入后的剩余容量 ~$square$


=== 0-1 背包问题 — PTAS
<01背包-PTAS>

#algorithm[0-1背包 PTAS][
  *输入*：物品集合（按 $v_i/w_i$ 降序排列），近似参数 $k$\
  *输出*：$(1+1/k)$-近似解

  + 令 $epsilon arrow.r 1/k$
  + 枚举所有大小 $lt.eq k$ 的子集，对每个子集执行 G-KK 填充剩余容量
  + 输出 $max{ A_0(I), dots, A_k(I) }$

  *时间复杂度*：$O(k n^(k+1))$
  *近似比*：$R_k = frac("OPT"(I), A_epsilon(I)) lt 1 + frac(1, k) = 1 + epsilon$
]


  #emph[Proof.] #strong[时间复杂度分析]：
  - 子集枚举量：$sum_(j=0)^k binom(n, j) = O(k n^k)$
  - 每次 G-KK 计算：$O(n)$
  - 总时间：$O(k n^(k+1))$

  #strong[近似比证明]：设最优解 $X$，分两种情况：

  + 若 $||X|| lt.eq k$：算法必得 $X$（因枚举所有 $lt.eq k$ 的子集）
  + 若 $||X|| gt k$：
    - 取 $Y subset X$ 为前 $k$ 个最大价值物品
    - 设 $Z = X \ Y = { u_(k+1), dots, u_r }$（保持 $v_j/w_j$ 降序）
    - 设 $u_m$ 为 $Z$ 中第一个未被算法装入的物品
    - 定义 $W$ 为算法在 $u_m$ 前装入的非 ${ u_1, dots, u_m }$ 物品

    关键推导：
    $
      C' & = C - sum_(j=1)^k w_j - sum_(j=k+1)^(m-1) w_j \
      C'' & = C' - sum_(u_j in W) w_j lt w_m quad ("因 " u_m " 未装入") \
      "OPT"(I) & lt.eq sum_(j=1)^k v_j + sum_(j=k+1)^(m-1) v_j + C' v_m / w_m \
      & lt sum_(j=1)^k v_j + sum_(j=k+1)^(m-1) v_j + sum_(u_j in W) v_j + v_m quad ("因 " v_j/w_j gt.eq v_m/w_m) \
      & lt A_epsilon(I) + frac("OPT"(I), k+1) quad ("因 " (k+1) v_m lt.eq "OPT"(I)) \
      arrow.r.double R_k & lt 1 + frac(1, k) = 1 + epsilon ~$square$
    $


=== 0-1 背包问题 — FPTAS（标度变换法）
<01背包-FPTAS>

#strong[构造 FPTAS 的一般方法]：
+ 设原问题实例 $I$ 的输入值为 $x_1, dots, x_k$
+ 伪多项式算法 $A$ 运行时间为 $T(n, sum x_i)$
+ 进行标度变换：$x'_i = floor.l frac(x_i, f(epsilon)) floor.r$
+ 得到新实例 $I'$
+ 用算法 $A$ 求解 $I'$ 得解 $S'$
+ 证明 $S'$ 是 $I$ 的 $(1+epsilon)$-近似解

#strong[0-1 背包的 FPTAS]：

$ K arrow.l frac(C, 2(k+1)n),quad C' arrow.l floor.l C / K floor.r $
创建新实例 $I' = (C', { (s'_i, v'_i) }_(i=1)^n )$
$ S arrow.l "KNAPSACK"(I') $

#strong[性质]：
- 构成算法簇：对每个 $k$，$epsilon = 1/k$，记为 $A_epsilon$
- 时间复杂度：$Theta(n^2 / epsilon)$

  对每个整数 $k gt 1$，$epsilon = 1/k$ 和任意实例 $I$：
  $"OPT"(I) lt (1 + epsilon) A_epsilon(I) $
  时间复杂度为 $Theta(n^2 / epsilon)$。


  #emph[Proof.] #strong[时间复杂度分析]：
  $
    T(n) & = Theta(n C' / K) \
         & = Theta(n dot.op C / K dot.op 1 / K) \
         & = Theta(n dot.op frac(2(k+1)n, K)) \
         & = Theta(k n^2) = Theta(n^2 / epsilon)
  $

  #strong[近似比证明]：设 $I'$ 为标度变换后的实例：

  - $"OPT"(I') gt.eq sum_(i in S^(*)) floor.l v_i / K floor.r$（$S^*$ 是最优解）
  - 有不等式链：
    $
      "OPT"(I) - K dot.op "OPT"(I') & lt.eq K n quad ("最优解至多 " n " 项") \
      "OPT"(I) - A_epsilon(I) & lt.eq K n quad ("近似解定义") \
      A_epsilon(I) & gt.eq "OPT"(I) - K n \
      & = "OPT"(I) - frac(C, 2(k+1))
    $

  - 假设 $"OPT"(I) gt.eq C/2$（否则易得最优解），则：
    $
      frac(A_epsilon(I), "OPT"(I)) & gt.eq 1 - frac(1, 2(k+1) "OPT"(I) / C) \
      & gt 1 - frac(1, k+1) = frac(k, k+1) \
      arrow.r.double R_(A_epsilon) & lt frac(k+1, k) = 1 + frac(1, k) = 1 + epsilon
    $


#remark[
  0-1 背包问题是完全可近似问题的代表，存在 FPTAS。其核心思想是 #strong[标度舍入]：将物品价值按比例缩小取整，使伪多项式 DP 算法在舍入后的问题上多项式运行，再证明舍入误差可控在 $(1+epsilon)$ 范围内。
]

== 课后作业
<课后作业>

=== 独立集问题
<独立集问题>

#problem[独立集问题][
  给出一个独立集问题的近似算法，即找到最大的顶点子集，子集中顶点互不相连。并请证明或否定该近似算法的近似度是有界的。
]

==== 贪心算法

#algorithm[独立集贪心算法][
  *输入*：无向图 $G = (V, E)$
  *输出*：独立集 $S$

  + 初始化独立集 $S = nothing$。
  + 从图中选择一个度数最小的顶点 $v$，将其加入 $S$。
  + 将 $v$ 及其所有邻居从图中删除。
  + 重复步骤 2-3，直到图中没有剩余顶点。
]

每次选择一个顶点加入 $S$ 时，最多会"排除" $Delta + 1$ 个顶点（包括该顶点及其邻居）。因此，贪心算法得到的独立集大小至少为 $frac("OPT", Delta + 1)$，其中 $"OPT"$ 是最优解的大小。

=== 最大子集和问题 — FPTAS
<最大子集和问题>

#problem[最大子集和问题][
  给定含有 $n$ 个正整数的集合 $S = { s_1, s_2, dots, s_n }$ 和一个正整数 $C$，要求找出 $S$ 的一个子集，使得它们的和最大且不超过 $C$。请给出求解该问题的完全多项式近似方案，要求分析算法时间复杂度和近似比。
]

==== FPTAS 算法

#algorithm[最大子集和 FPTAS][
  *输入*：集合 $S$，上限 $C$，近似参数 $epsilon$
  *输出*：不超过 $C$ 的最大子集和

  + 设定近似参数 $epsilon in (0,1)$，计算缩放因子 $k = frac(epsilon dot.op max(S), n)$。
  + 对集合 $S$ 中每个元素 $s_i$，计算缩放后的值 $s'_i = floor.l s_i / k floor.r$。
  + 使用动态规划求解缩放后的问题：
    - 定义 $"dp"[i][j]$ 表示前 $i$ 个元素能否组成和 $j$
    - 初始化 $"dp"[0][0] = "True"$
    - 状态转移：$"dp"[i][j] = "dp"[i-1][j] "or" "dp"[i-1][j-s'_i]$
  + 在满足 $sum_(i in T) s'_i lt.eq floor.l C/k floor.r ≜ J_max$ 的所有子集 $T$ 中，利用 $"dp"[n][dot.op]$ 来找到使 $sum_(i in T) s_i$ 最大的解。
]

#strong[时间复杂度分析]：
- 参数缩放阶段：$O(n)$
- 动态规划阶段：$J_max = O(frac(n C, epsilon max(S)))$，状态转移次数 $O(n dot.op J_max) = O(frac(n^2 C, epsilon max(S)))$
- 总时间复杂度：$T(n, epsilon) = O(frac(n^2 C, epsilon max(S))) lt.eq O(n^2 / epsilon)$

#strong[近似比推导]：
$
  forall s_i : & k dot.op s'_i lt.eq s_i lt.eq k (s'_i + 1) \
  & sum_(i in T) s_i - k sum_(i in T) s'_i lt.eq n k = epsilon max(S) \
  "ALG" gt.eq k dot.op "OPT"' gt.eq "OPT" - n k = "OPT" - epsilon max(S) \
  R_("ALG") = frac("OPT", "ALG") lt.eq frac("OPT", "OPT" - epsilon max(S))
$
若 $max(S) lt.eq "OPT"$，则易知 $R_("ALG") lt.eq 1 + epsilon$；若 $max(S) gt "OPT"$，则对该算法进行修正，将所有满足 $s_i gt C$ 的 $s_i$ 均删除，再次进行计算，即可转化为上一种情况。

=== 无向图最大割集问题
<无向图最大割集问题>

#problem[最大割集问题][
  设无向图 $G = (V, E)$，$V_1 union V_2 = V, V_1 inter V_2 = nothing$。若边 $(u,v) in E$ 且 $u in V_1$、$v in V_2$，则称 $(u,v)$ 为割边；否则称为非割边。求最大割集问题：任给无向图 $G = (V, E)$，求 $G$ 的边数最多的割集。
]

==== MCUT 局部改进算法

#algorithm[MCUT][
  *输入*：无向图 $G = (V, E)$
  *输出*：割集 $(V_1, V_2)$

  + 初始令 $V_1 = V$，$V_2 = nothing$。
  + 重复以下操作：
    - 若存在顶点 $u$，在 $u$ 关联的边中非割边数 $gt$ 割边数
      - 若 $u in V_1$，则将 $u$ 移至 $V_2$
      - 若 $u in V_2$，则将 $u$ 移至 $V_1$
  + 直到不存在这样的顶点时停止
]

最终得到的 $(V_1, V_2)$ 即为解。对任意实例满足 $"OPT"(I) lt.eq 2 dot.op "MCUT"(I)$，其中 $"OPT"(I)$ 表示最优解的边数。

#emph[Proof.] 设 $C$ 为算法得到的割边数 $"MCUT"(I)$。设顶点 $u$ 的割边与非割边数分别是 $c(u)$ 和 $"nc"(u)$。

每条割边连接 $V_1$ 和 $V_2$，因此 $sum_(u in V) c(u) = 2C$。因为 $c(u) gt.eq "nc"(u)$，所以对于每个顶点 $u$，其度数 $d(u) = c(u) + "nc"(u) lt.eq 2 times c(u)$，那么 $c(u) gt.eq frac(d(u), 2)$。因此：
$ 2C = sum_(u in V) c(u) gt.eq frac(1, 2) sum_(u in V) d(u) = ||E|| $
所以 $"OPT"(I) lt.eq ||E|| lt.eq 2C = 2 dot.op "MCUT"(I)$。~$square$


=== 平面 TSP 的最小权匹配近似紧例
<平面TSP最小权匹配>

#problem[平面TSP最小权匹配紧例][
  对 TSP 问题所有满足三角不等关系的实例 $I$，已知有最小权匹配（"MM"）近似算法求解，且 $"MM"(I) lt frac(3, 2) "OPT"(I)$，请给出具有该近似比的紧实例。
]

#emph[思路]：这个题需要让顶点数 $n$ 趋于无穷，使得 $"length"(T) arrow.r "OPT"(I)$、$"length"(M) arrow.r frac(1, 2) "OPT"$。这里我们必须约定找到的最小生成树满足某些特殊的性质，使得 $n$ 个点中度数为奇数的点的数量是接近 $n$ 的，这样就可以使得 $"length"(M) arrow.r frac(1, 2) "OPT"$。而且依靠这个最小生成树得到的欧拉图，必须是能够变成哈密尔顿回路的，即不存在割点。

按照以上原则进行构造即可。


=== 最大团问题 — FPTAS
<最大团问题>

#problem[最大团问题][
  给定近似参数 $epsilon$，假设存在一个近似比为常数 $rho$ 的算法 $A$ 用于求解最大团问题。对于图 $G = (V, E)$，设其最大团大小为 $m$。
]

==== FPTAS 构造

#algorithm[最大团 FPTAS][
  *输入*：图 $G = (V, E)$，近似参数 $epsilon$
  *输出*：近似最大团 $C$

  + 计算 $k = ceil.l 1 / log_c (1+epsilon) ceil.r$
  + 构造图 $G^((k))$
  + 使用算法 $A$ 在 $G^((k))$ 中找到大小为 $n$ 的团
  + 将 $G^((k))$ 的团映射回 $G$，得到团 $C$
]

$
  m / n^(1/k) & lt.eq c^(1/k) \
  "令" quad k & = frac(1, log_c (1+epsilon)) \
  arrow.r.double m / n^(1/k) & lt.eq 1 + epsilon \
  arrow.r.double n^(1/k) & gt.eq frac(m, 1 + epsilon)
$

$
  k = frac(1, log_c (1+epsilon)) = frac(ln c, ln (1+epsilon))
    gt.eq frac(ln c, epsilon) quad ("因为 " ln (1+epsilon) lt.eq epsilon)
$

因此算法 $A'$ 满足：
- 近似比：$1 + epsilon$
- 时间复杂度：关于 $||V||$ 和 $1/epsilon$ 的多项式

上述构造证明了最大团问题存在完全多项式时间近似模式（FPTAS），其中：
$ "输出团大小" gt.eq frac(m, 1 + epsilon) $
且运行时间关于输入规模和 $1/epsilon$ 均为多项式级别。
