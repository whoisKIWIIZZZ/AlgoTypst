#import "@local/ysz_tools:0.1.0": *

#show: conf.with(
  sidebar: false,
)


= chapter5: 贪心算法
<chapter5-贪心算法>
贪心算法很难有具体可行的方法对其适用性进行判定，但是一般具有2个重要的性质：#strong[贪心选择性质]和#strong[最优子结构性质]。

所谓贪心选择性质是指所求问题的整体最优解可以通过一系列局部最优的选择，即贪心选择来达到。这意味着每一步的最优选择不会影响未来的选择，即当前的选择只依赖于当前的状态，而不依赖于未来的状态。

#strong[对于一个约束优化问题：]

+ #strong[可行解]：如果决策序列是关于一个问题的完整解的形式，且不破坏问题的约束条件，则称它为该问题的可行解。

+ #strong[部分可行解]：如果一个决策序列是问题的完整解形式的一部分，且满足约束条件，则称它为部分可行解。

+ #strong[不可行的（部分）解]：不满足问题约束条件的完整或部分解形式的决策序列，称为不可行的（部分）解。

+ #strong[最优解]：使目标函数值取最优值的可行解，称为最优解。

+ #strong[贪心解]：通过贪心算法得到的可行解，称为贪心解。

+ #strong[贪心解性质]：贪心解不一定是最优解。

== 贪心算法思想
<贪心算法思想>
#block[
  贪心算法一般框架 \
  #strong[Algorithm GREEDY($A$, $n$)] $s o l u t i o n arrow.l diameter$
  #strong[return] ($s o l u t i o n$)

]
+ #strong[贪心选择性质]:
  通过SELECT函数保证每一步选择都是当前最优，且该选择最终能导向全局最优解(需进行数学证明)

+ #strong[最优子结构]: FEASIBLE函数确保解集的逐步扩展不破坏问题结构。

+ #strong[终止条件]:
  循环n次确保覆盖所有候选元素，最终解集solution必然完备。

贪心算法产生全局最优解的最重要因素是选择策略，采用的贪心准则/贪心度量。

== 贪心算法举例
<贪心算法举例>

以下是为你整理的关于“最大股票收益问题”和“分数背包问题”的 Typst 格式笔记。针对这些算法概念，我结合了你偏好的“5-MINUTE LEARNINGS”与“BOTTOM-UP”步骤进行解析。


=== 最大股票收益问题 (Best Time to Buy and Sell Stock)

#unim[
  *题面*：给定一个数组 $P$，其中 $P[i]$ 表示某支股票第 $i$ 天的价格。你只能选择某一天买入，并在未来的某一天卖出。设计一个算法来计算你所能获取的最大利润。
]

*思路*：遍历价格数组，记录当前遍历过的最低价格（作为潜在买入点），同时计算每一天卖出可能获得的利润，通过一次遍历更新全局最大值。

股票收益的核心在于*价格差的最大化*。我们将问题转化为寻找 $P[j] - P[i]$ 的最大值，其中 $j > i$。

1. *状态定义*：定义 `min_price` 为区间 $[0, i]$ 内的最低价格；`max\_profi` 为前 $i$ 天能获得的最大收益。
2. *状态转移*：
  - 更新最小值：`min_price` = `min(min_price, P[i])`
  - 尝试卖出：当前收益 Profit_i = P[i] - min\_price
3. *决策选择*：如果 Profit_i 大于已知的 max\_profit，则更新最大利润。
4. *复杂度*：时间复杂度 $O(n)$，空间复杂度 $O(1)$。


=== 分数背包问题 (Fractional Knapsack Problem)

#unim[
  *题面*：给定 $n$ 个物品，每个物品 $i$ 有价值 $v_i$ 和重量 $w_i$。现有一个容量为 $W$ 的背包，你可以选择将物品的一部分放入背包（即允许取分数倍）。求背包能装下的最大总价值。
]

*思路*：计算每个物品的单位价值（性价比），按照单位价值从高到低进行贪心选择。如果剩余容量不足以装下整个物品，则切分该物品填满背包。

分数背包与 0/1 背包的区别在于其“可分性”。这种性质使得*贪心策略*能直接达到全局最优解。

1. *计算性价比*：计算每个物品的单位价值 $rho_i = v_i / w_i$。
2. *排序*：将所有物品按 $rho_i$ 从大到小降序排列。
3. *贪心填充*：
  - 依次选取排序后的物品。
  - 若 $W \ge w_i$，则全额放入，更新 $W = W - w_i$。
  - 若 $W < w_i$，则放入当前物品的 $W / w_i$ 部分，将背包填满并停止。
4. *核心公式*：
  #mi(`V_{total} = \sum_{i \in \text{Full}} v_i + \left( W_{rem} \cdot \frac{v_j}{w_j} \right)`)




=== Dijkstra 算法
<dijkstra-算法>
#block[
#mitex(`$$
\begin{aligned}
& \textbf{Algorithm: Dijkstra}(V, E, w, s=1) \\
\hline
& \text{1. Initialization:} \\
& \quad dist[1] \gets 0, \quad dist[v] \gets \infty \quad (\forall v \in V \setminus \{1\}) \\
& \quad prev[v] \gets \text{undefined} \quad (\forall v \in V) \\
& \quad Q \gets \text{MinPriorityQueue}(V) \quad (Y = V, X = \emptyset) \\
& \text{2. Iteration:} \\
& \quad \textbf{while } Q \neq \emptyset: \\
& \quad \quad u \gets \text{ExtractMin}(Q) \quad (u \text{ moves from } Y \text{ to } X) \\
& \quad \quad \textbf{for each } \text{neighbor } v \text{ of } u: \\
& \quad \quad \quad \text{if } dist[u] + w(u, v) < dist[v]: \\
& \quad \quad \quad \quad dist[v] \gets dist[u] + w(u, v) \quad (\text{Relaxation: } \lambda[v] \downarrow) \\
& \quad \quad \quad \quad prev[v] \gets u \\
& \quad \quad \quad \quad \text{DecreaseKey}(Q, v, dist[v]) \\
& \text{3. Result:} \\
& \quad \textbf{return } (dist, prev) \quad (\text{where } dist[v] = \delta[v] \text{ for all } v \in X)
\end{aligned}
$$`)

]
- $lambda \[ v \]$：算法中顶点$v$的当前距离标记（对应伪代码中的$d i s t \[ v \]$）

- $delta \[ v \]$：从源点$1$到$v$的真实最短路径长度

- $Y$：未处理的顶点集合（对应优先队列$Q$）

- $X$：已处理的顶点集合（$X = V \\ Y$）

在Dijkstra算法中，当顶点$y$在第8步（ExtractMin操作）被选中且$lambda \[ y \]$有限时，有：
$ lambda \[ y \] = delta \[ y \] $

第一个离开$Y$的顶点是源点$1$，初始化时：
$ lambda \[ 1 \] = delta \[ 1 \] = 0 quad upright("（显然成立）") $

假设对于所有在$y$之前离开$Y$的顶点$x$，都有：
$ lambda \[ x \] = delta \[ x \] $ 下证对$y$也成立。

+ 路径存在性：由于$lambda \[ y \]$有限，必存在从$1$到$y$的路径$P$，其长度为$lambda \[ y \]$。

+ 关键路径构造：设$pi = 1 arrow.r dots.h.c arrow.r x arrow.r w arrow.r dots.h.c arrow.r y$是从$1$到$y$的真实最短路径（$pi$具有子问题最优性，否则一定存在一个更短的子路径优化$pi$），其中：

  - $x$是路径$pi$上最后一个在$y$之前离开$Y$的顶点

  - $w$是$x$的后继节点

+ 不等式链：
  $
    lambda \[ y \] & lt.eq lambda \[ w \] quad upright("（因为") y upright("先于") w upright("被选中）") \
                   & lt.eq lambda \[ x \] + upright("length") \( x \, w \) quad upright("（松弛操作保证）") \
                   & = delta \[ x \] + upright("length") \( x \, w \) quad upright("（归纳假设）") \
                   & = delta \[ w \] quad upright("（") pi upright("的子路径最优性）") \
                   & lt.eq delta \[ y \] quad upright("（非负权重下子路径") lt.eq upright("全路径）")
  $

+ 等号成立：由于$lambda \[ y \]$是某条路径的实际长度，而$delta \[ y \]$是最短长度，故：
  $ lambda \[ y \] gt.eq delta \[ y \] $ 结合上述不等式链，最终得：
  $ lambda \[ y \] = delta \[ y \] $

- 子路径不等式：保证$delta \[ w \] lt.eq delta \[ y \]$（否则$x arrow.r w arrow.r y$可能比全局最短路径更长）

- 松弛有效性：确保$lambda \[ w \] lt.eq lambda \[ x \] + upright("length") \( x \, w \)$不会被负权边破坏

- 反例：若$upright("length") \( x \, w \) < 0$，可能导致$delta \[ w \] > delta \[ y \]$，破坏归纳链条

朴素的数组实现的dijkstra算法的复杂度是$O \( n^2 + m \)$，如果用堆进行优化，时间复杂度是$O \( n + m \) log n$\($n$是顶点数量，$m$是边数量)。如果是稠密图的话，会使得堆优化速度更慢，所以在稠密图（邻接矩阵存储）情况下，应该用前者。

=== Kruskal算法
<kruskal算法>
#remark[每次把最短的且不构成回路的边加入，直到成功构建最小生成树。]

对于Kruskal算法，算法的时间复杂度取决于排序步骤，所以是$O \( m log m \)$.

- $G = \( V \, E \)$：带权无向连通图

- $T_(upright("mst"))$：任意一棵最小生成树

- $A_k$：算法在第$k$步迭代后加入的边集（初始化$A_0 = diameter$）

$forall k gt.eq 0$，$A_k subset.eq T_(upright("mst"))$（即$A_k$总是某个MST边的子集）

+ #strong[基础步骤]（$k = 0$）：

  $A_0 = diameter$，空集是任何集合的子集，显然$A_0 subset.eq T_(upright("mst"))$。

+ #strong[归纳步骤]：

  假设$A_k subset.eq T_(upright("mst"))$，设$e = \( u \, v \)$是第$k + 1$步选择的边：

  - 根据算法：$e$是当前权重最小且不产生环的边（即$e$连接$A_k$中两个不同连通分量）

  - 根据安全边引理：$A_k union { e }$是某个MST边的子集

  $therefore A_(k + 1) = A_k union { e } subset.eq T'_(upright("mst"))$（$T'_(upright("mst"))$为新的最小生成树）

+ #strong[终止条件]：

  当$\| A_(upright("final")) \| = \| V \| - 1$时：

  - $A_(upright("final"))$无环（算法保证）

  - $A_(upright("final"))$连通所有顶点（否则存在连接不同分量的安全边，算法不会终止）

  - $A_(upright("final")) subset.eq T_(upright("mst"))$且$\| A_(upright("final")) \| = \| T_(upright("mst")) \|$

  $arrow.r.double A_(upright("final"))$即为一棵最小生成树

下面用反证法证明#strong[安全边引理]

假设存在权重最小的跨分量边
$e in.not T_(upright("mst"))$（$T_(upright("mst"))$ 是包含 $A$
的最小生成树）

+ 将 $e$ 加入 $T_(upright("mst"))$，形成唯一环 $C$（因树加边必成环）

+ 环 $C$ 上必存在边 $e' = \( x \, y \)$ 满足：

  - $e' eq.not e$

  - $e'$ 连接 $A$ 的不同连通分量（因 $e$ 连接两个分量）

  - $w \( e' \) gt.eq w \( e \)$（因 $e$ 是权重最小的跨分量边）

+ 构造新生成树：$T_(upright("new")) = T_(upright("mst")) union { e } \\ { e' }$

  - 总权重：$w \( T_(upright("new")) \) = w \( T_(upright("mst")) \) + w \( e \) - w \( e' \) lt.eq w \( T_(upright("mst")) \)$

  - 当 $w \( e \) < w \( e' \)$
    时：$w \( T_(upright("new")) \) < w \( T_(upright("mst")) \)$（与
    $T_(upright("mst"))$ 最小性矛盾）

  - 当 $w \( e \) = w \( e' \)$ 时：$T_(upright("new"))$
    也是最小生成树，且包含 $A union { e }$

=== Prim算法
<prim算法>
Prim
算法一般复杂度为$Theta \( m + n^2 \)$，可以被堆优化为$O \( m log n \)$.

给出一个含权无向图$G = \( V \, E \)$，其中$\| V \| = n$，$\| E \| = m$：

- 算法MST可在$O \( m log n \)$时间内找出最小生成树

- #strong[稠密图特例]：若存在$epsilon > 0$使得$m gt.eq n^(1 + epsilon)$，则时间复杂度可改进为$O (m / epsilon)$

设$epsilon$为固定常数，其技术意义体现在：

$
  frac(m log n, m \/ epsilon) = epsilon log n quad arrow.r.double quad cases(delim: "{", upright("当 ") m = n^(1 + epsilon) upright(" 时") \, & upright("加速比为 ") Theta \( epsilon log n \), epsilon = Omega \( 1 \) upright(" 时") \, & O (m / epsilon) upright(" 严格优于 ") O \( m log n \))
$

+ #strong[稠密度控制]：$epsilon$量化图的稠密程度
  $ m = n^(1 + epsilon) arrow.r.double.long upright("边数 ") m upright(" 远超顶点数 ") n $

+ #strong[复杂度改进]：当$epsilon$为常数时
  $ O (m / epsilon) = O \( m \) quad upright("（线性时间优于 ") O \( m log n \) upright("）") $

+ #strong[实际意义]：对满足$exists c > 0 \, m > n^(1 + c)$的图，算法有显著加速

该定理的正确性建立在图论（稀疏/稠密图分类）与数据结构（斐波那契堆优化）的交叉分析上，其核心在于发现：当边数足够多时（$m gt.double n$），可以通过特殊数据结构设计消除对数因子。

Prim算法可以正确处理包含负权边的图的最小生成树(MST)问题，其正确性不受边权值符号的影响。

#block[
  #emph[Proof.]
  设$T_min$是$G$的最小生成树。将$T$中的$n - 1$条边按权重从小到大排列为$e_(k_1) \, e_(k_2) \, dots.h.c \, e_(k_(n - 1))$，将$T_min$中的边同样排列为$e_(g_1) \, e_(g_2) \, dots.h.c \, e_(g_(n - 1))$。从头开始比较：

  设第一条属于$T$但不属于$T_min$的边为$e_(k_i) = \( u_i \, v_i \)$，则在$T_min$中存在一条属于$T_min$但不属于$T$的边$e_(g_j) = \( u_i \, v_(*) \)$。根据Prim算法的性质(2)可知：
  $ w \( e_(k_i) \) lt.eq w \( e_(g_j) \) $

  在$T_min$中删除$e_(g_j)$并加入$e_(k_i)$得到新树$T_(upright("new"))$，满足：
  $ upright("cost") \( T_min \) gt.eq upright("cost") \( T_(upright("new")) \) $
  由于$T_min$是最小生成树，又有：
  $ upright("cost") \( T_min \) lt.eq upright("cost") \( T_(upright("new")) \) $
  故必然有：
  $ upright("cost") \( T_min \) = upright("cost") \( T_(upright("new")) \) $
  即$T_(upright("new"))$也是最小生成树。

  重复此替换过程直至$T_(upright("new")) = T$，最终证明$T$是最小生成树。~◻

]
=== 活动选择问题
<活动选择问题>
#unim[你有n个活动构成的集合$S = { a_1 \, a_2 \, dots.h \, a_n }$，这些活动都需要占用会议室，且每个时刻会议室只能给一场活动提供服务。

每个活动$a_i$的开始时间为$s_i$，结束时间为$f_i$，其中$0 lt.eq s_i < f_i < oo$。如果活动$a_i$占用的时间为区间$\[ s_i \, f_i \)$。

如果活动$a_i$和$a_j$的时间区间$\[ s_i \, f_i \)$和$\[ s_j \, f_j \)$没有重叠，那么活动$a_i$和$a_j$相互兼容。

目标：从所有活动中选出一个总时间规模最大相互兼容的活动子集。]

如果给定活动序列没有按照结束时间从小到大排序，先进行排序，这步预处理非常重要，没有这步预处理，后面的贪心策略就无从开展。(其实也可以选择最晚开始的活动，思路与最早结束大体一致，不再额外展开)

下面开始使用贪心策略求解，贪心策略每一步都要作出贪心选择(greedy
choice)，这样只有一个子问题需要处理。下面会分别讨论贪心的递归算法和迭代算法。

下面证明活动选择问题具有最优子结构。

定义$S_(i j)$为$a_i$结束后$a_j$开始前的活动集合，定义$A_(i j)$为$S_(i j)$中规模最大且相互兼容的活动子集。$A_(i j)$中包含活动$a_k$，和两个子问题$A_(i k)$和$A_(k j)$。定义$A_(i k) = A_(i j) sect S_(i k)$且$A_(k j) = A_(i j) sect S_(k j)$，这样有$A_(i j) = A_(i k) union { a_k } union A_(k j)$，所以有$\| A_(i j) \| = \| A_(i k) \| + \| A_(k j) \| + 1$。

用#strong[剪切粘贴]方法可以证明最优解$A_(i j)$一定包含两个子问题$S_(i k)$和$S_(k j)$的最优解。如果你能找到一个由$S_(k j)$相互兼容的活动组成的集合$A'_(k j)$，其中$\| A'_(k j) \| > \| A_(k j) \|$，那么你就可以用$A'_(k j)$替换$A_(k j)$。此时就能构造出规模为

$\| A_(i k) \| + \| A'_(k j) \| + 1 > \| A_(i k) \| + \| A_(k j) \| + 1 = \| A_(i j) \|$

的相互兼容的活动集合，与$A_(i j)$是最优解矛盾。同理也可以用于证明子问题$S_(i k)$。

定义$S_(i j)$的最优解的规模为$c \[ i \, j \]$，运用动态规划方法可以写出递归式：$c \[ i \, j \] = c \[ i \, k \] + c \[ k \, j \] + 1$，即：

$c \[ i \, j \] = cases(delim: "{", 0 & S_(i j) = nothing, max_(a_k in S_(i j)) { c \[ i \, k \] + c \[ k \, j \] + 1 } & S_(i j) eq.not nothing)$

虽然我们可以用动态规划方法求解，但是我们忽略了活动选择问题的一个重要特征，这个特征可以大大提高问题求解速度。

考虑任意非空子问题$S_k$，如果$a_m$是$S_k$中结束时间最早的活动，那么$a_m$在$S_k$的某个最大兼容活动子集中。

下面证明活动选择问题具有贪心选择性质：
证明：定义$A_k$是$S_k$的最大兼容活动子集，且$a_j$是$A_k$中结束时间最早的活动。

若$a_j = a_m$，则已证明$a_m in A_k$。

若$a_j eq.not a_m$，令$A'_k = \( A_k - { a_j } \) union { a_m }$，则$\| A_k \| = \| A'_k \|$。又$a_j$是$A_k$中结束时间最早的活动，$a_m$是$A'_k$中结束时间最早的活动，$f_m lt.eq f_j$。所以$A'_k$是$S_k$的最大兼容活动子集，$a_m in A'_k$。

我们每次选择结束时间最早的且与当前活动兼容的活动，重复执行这个过程直到没有剩余活动可以选择。所选择的活动的结束时间必然是严格递增的。所以我们只需要按照结束时间单调递增的顺序处理所有活动，每个活动仅需要考察一次。

#block[
  #strong[function] RECURSIVE-ACTIVITY-SELECTOR($s$, $f$, $k$, $n$):

  $m arrow.l k + 1$
  
  $upright("RECURSIVE-ACTIVITY-SELECTOR") \( s \, f \, 0 \, n \)$

]
当然也可以用动态规划的思想实现，同时用二分的思路对其进行优化,
时间复杂度仍为$O \( n log n \)$：

#block[
  #strong[function] DP-ACTIVITY-SELECTOR($s$, $f$, $n$) let
  $c \[ 0 . . n \]$ be new array $c \[ 0 \] arrow.l 0$

  #strong[return] $c \[ n \]$

]
思考活动选择问题的一个变型：每个活动$a_i$除了开始时间和结束时间外，还有一个权值$v_i$。目标不再是求规模最大的活动子集，而是求权值总和最大的活动子集，也就是选择一个活动集合A，使得$sum_(a_k in A) v_k$最大化。设计一个多项式时间的算法求解该问题。

其实就只需要修改一下动态规划算法的比较项就可以了，不再做更多展开。

=== 区间图着色问题
<区间图着色问题>
假设有一组活动，将它们安排到一些讲堂，任意活动都可以在任意讲堂进行，我们希望用最少的教室完成所有活动，设计一个贪心算法求每个活动所在讲堂进行分配。

这个问题可以视为区间图着色问题(interval-graph coloring
problem)。区间图着色问题：构造一个区间图，顶点表示给定的活动，边连接不兼容的活动。要求用最少的颜色对顶点进行着色，相邻顶点的颜色不能相同。

一个朴素的方法是，每当有新活动时，就遍历所有讲堂，查看是否有空闲讲堂。如果没有空闲讲堂，就新开一个讲堂。为了方便选出空闲讲堂，我们可以使用优先队列。

算法执行步骤如下：

按照开始时间对活动进行排序。初始化一个小顶堆，按照结束时间排序，堆顶活动为最早结束的活动。检查每一个活动：如果堆为空，开辟一个新讲堂，选好讲堂后将活动加入堆中，同时将该活动记录到所在讲堂举行的活动名单中。如果堆不为空，和堆顶活动进行比较，如果堆顶活动的结束时间小于或等于当前活动的开始时间，将堆顶活动出队，并将当前活动放在堆顶活动所在讲堂进行，否则开辟一个新讲堂。选好讲堂后将活动加入堆中，同时将该活动记录到所在讲堂举行的活动名单中。所有活动检查结束后，输出所有讲堂举行的活动名单。

#block[
  按照开始时间 $s_i$ 对活动进行升序排序 初始化一个最小堆
  $H$，按结束时间排序 初始化空的讲堂列表 $c l a s s r o o m s$

]
=== 最小延迟调度问题
<最小延迟调度问题>
给定 $n$ 个作业，每个作业 $J_i$ 有一个处理时间 $t_i$ 和截止时间
$d_i$。调度方案需为作业排列一个顺序，使得所有作业的延迟（完成时间减去截止时间）的最大值最小化。形式化定义为：

- 作业顺序
  $sigma = \( J_(sigma \( 1 \)) \, dots.h \, J_(sigma \( n \)) \)$
  的完成时间 $C_(sigma \( i \)) = sum_(k = 1)^i t_(sigma \( k \))$。

- 延迟
  $L_(sigma \( i \)) = max \( 0 \, C_(sigma \( i \)) - d_(sigma \( i \)) \)$。

- 目标是最小化 $L_max = max_i L_(sigma \( i \))$。

#block[
  按照截止时间 $d_i$ 对任务进行升序排序，使得
  $d_1 lt.eq d_2 lt.eq dots.h lt.eq d_n$
  初始化完成时间数组：$f \( 1 \) arrow.l 0$ 初始化计数器：$i arrow.l 2$

]
显然，所有无逆序且无空闲时间的调度具有相同的最大延迟。即对于满足$d_(sigma \( 1 \)) lt.eq dots.h.c lt.eq d_(sigma \( n \))$的调度$sigma$，其$L_max$仅取决于任务顺序，与相同截止时间任务的内部排列无关。

下面证明： 按$d_i$升序排列（EDD策略）的调度$sigma^(\*)$是最优解。

若$d_i > d_j$但$i$排在$j$前，则称#strong[相邻]任务对$\( J_i \, J_j \)$为#strong[逆序对]。

对任意含逆序对$\( J_i \, J_j \)$的调度$sigma$：
$
  upright("交换前延迟") & : L_i = C + t_i - d_i \, quad L_j = C + t_i + t_j - d_j \
  upright("交换后延迟") & : L'_j = C + t_j - d_j \, quad L'_i = C + t_j + t_i - d_i
$
其中$C$为$J_i$的开始时间。由于$d_i > d_j$且$t_j > 0$：
$ max \( L'_j \, L'_i \) lt.eq max \( L_i \, L_j \) $

通过有限次相邻交换可消除所有逆序对：

- 每次交换不增加$L_max$

- 最终得到无逆序的EDD调度

- 由引理1知此调度最优

=== 分数背包问题
<分数背包问题>
给出n个大小为$s_1$，$s_2 \, dots.h.c \, s_n$，值为$v_1$，$v_2 \, dots.h.c \, v_n$的物品，并设背包的容量为$C$。要求找到非负实数$x_1$，$x_2 \, dots.h.c \, x_n$，使得在满足不超过背包总容量的约束条件下，装进背包物品部分总价值最大。

即，最大化$sum_(i = 1)^n x_i v_i$且满足$sum_(i = 1)^n x_i s_i lt.eq C$

选择单位大小的价值最大的物品即可，不过多展开了（过于简单）

=== 带期限作业排序问题
<带期限作业排序问题>
问题：设有一个单机系统、无其它资源限制且每个作业运行相等时间，不妨假定每个作业运行
1 个单位时间。现有 $n$ 个作业，每个作业都有一个截止期限$d_i > 0$，$d_i$
为整数。如果作业能够在截止期限之内完成，可获得 $p_i > 0$
的收益。问题要求得到一种作业调度方案，该方案给出作业的一个子集和该作业子集的一种排列，使得若按照这种排列次序调度作业运行，该子集中的每个作业都能如期完成，并且能够获得最大收益。

思路：将输入的每个作业按收益从大到小进行排序，用一个数组$v i s$表示某时刻是否已经有作业正在运行，$v i s \[ i \] = 1$，表示时间i被占用
。然后从第1个作业开始往后搜索，将该作业安排到$v i s \[ d \]$时间运行，如果$d$已经有安排，将从$d - 1$开始往前搜索，直到找到一个未被占用的时间点。如果找不到空时间点，则跳过此作业，继续向后搜索直到所有作业都搜索完。

#block[
  按照收益 $p_i$ 对作业进行降序排序 初始化时间槽数组
  $v i s \[ 1 . . m a x \_ d \]$ 全为 $0$ 初始化结果列表
  $r e s arrow.l nothing$

]
#block[
  按效益值降序排列的贪心调度算法总能得到最优解。

]
#block[
  #emph[Proof.] 采用交换论证法，分三部分证明：

  #strong[\1. 基本设定]：

  - 设最优解作业集为$I$，贪心解为$J$

  - 若$I = J$则得证，故只需考虑$I eq.not J$的情况

  - 此时必有$I subset.not J$（否则$I$非最优）且$J subset.not I$（否则$J$更优）

  - 存在$a in J - I$和$b in I - J$，且由贪心法性质有$p_a gt.eq p_b$

  #strong[\2. 调度表调整]：

  + 设$S_J$和$S_I$分别为$J$和$I$的可行调度表

  + 对公共作业$i in I sect J$，调整调度表使得：

    - 若在$S_J$中$i$于$\[ t \, t + 1 \]$执行，在$S_I$中于$\[ t' \, t' + 1 \]$执行

    - 当$t < t'$时：将$S_J$中$\[ t' \, t' + 1 \]$的作业与$i$交换

    - 当$t' < t$时：对$S_I$做对称调整

  + 最终得到新调度表$S'_J$和$S'_I$，使公共作业执行时间一致

  #strong[\3. 最优性保持]：

  - 在调整后的$S'_I$中，将作业$b$替换为$a$，形成新解$I' = \( I - { b } \) union { a }$

  - 由于$p_a gt.eq p_b$，有$sum_(i in I') p_i gt.eq sum_(i in I) p_i$

  - 重复此过程可将$I$逐步转换为$J$而不降低总效益

  因此$J$必为最优解。~◻

]
#block[
  作业集合$J$可行的充要条件：存在按$d_i$非降序排列的调度序列$sigma$，使得$forall i in J$都在$d_i$前完成。

]
#block[
  #emph[Proof.] 必要性由定义显然。充分性证明：

  - 设$sigma$为按$d_i$非降序排列的调度

  - 若存在作业$i_k$在$sigma$中第$k$个执行且完成时间$k > d_(i_k)$

  - 则前$k$个作业的$d_(i_j) lt.eq d_(i_k) < k$，导致至少一个作业必然超期

  - 矛盾，故$sigma$必为可行调度

  ~◻

]
=== 黑白点最大匹配问题
<黑白点最大匹配问题>
#block[
  #strong[预处理阶段]： 将黑点 $B$ 按 $x^B$ #strong[升序]排列（$x$相同则按
  $y^B$ 升序） 将白点 $W$ 按 $x^W$ #strong[降序]排列（$x$相同则按 $y^W$
  降序）

  #strong[匹配阶段]： $c o u n t arrow.l 0$ $i arrow.l 1$, $j arrow.l 1$

]
#block[
  #emph[Proof.] 我们通过以下步骤证明：

  - 设最优匹配为$M^(*)$，其匹配数为$upright(O P T)$

  - 设算法得到的匹配为$M$，匹配数为$\| M \|$

  - 定义特征函数$phi.alt \( M \)$为匹配中黑点的字典序排列

  对于任意最优匹配$M^(*)$，存在匹配$M'$使得：

  + $\| M' \| = \| M^(*) \|$

  + $phi.alt \( M' \)$与算法输出$M$的字典序相同（可以通过调整使得相同）

  假设存在更优匹配$M^(*)$，取第一个差异点：

  + 设算法第$k$步选择$\( b_i \, w_j \)$

  + 而$M^(*)$选择$\( b_i \, w_(j') \)$或$\( b_(i') \, w_j \)$（如果不是则通过交换进行修正）

  + #strong[情况1]：$w_(j') eq.not w_j$
    $ upright("由于算法优先选") & upright("最大的") w_j \
               arrow.r.double & x_j^W gt.eq x_(j')^W \
                              & y_j^W gt.eq y_(j')^W $ 可交换$w_j$和$w_(j')$而不减少匹配数

  + #strong[情况2]：$b_(i') eq.not b_i$
    $ upright("算法选择") & upright("最小的") b_i \
         arrow.r.double & x_i^B lt.eq x_(i')^B \
                        & y_i^B lt.eq y_(i')^B $ 用$b_i$替换$b_(i')$可保持可行性

  上述交换均会使$M^(*)$的特征向量$phi.alt \( M^(*) \)$更接近算法结果$M$，与$M^(*)$的最优性假设矛盾。~◻

]
=== 过河问题
<过河问题>
Oliver和$N - 1$个朋友共$N$人需要从河东岸渡到西岸。他们只有一艘小船，每次最多可载两人。当两个人$i$和$j$一起渡河时，所需时间为$m a x \( T_i \, T_j \)$。求所有人过河的最少总时间。

很明显的贪心，主要讨论两种情况：
1、让速度最快的往返接送，每次送两个人所用时间为两倍最快的人所用的时间加上两个最慢的人的所用的时间之和。即$a \[ n \] + a \[ 1 \] + a \[ n - 1 \] + a \[ 1 \]$\;

2、先让两个最快的人过河，再让第二快(谁将船送回都不影响)的人送回船，让两个岁慢的人过河，再将留在河对面的速度最快的人把船送回。所用时间为$a \[ 2 \] + a \[ 2 \] + a \[ n \] + a \[ 1 \]$\;

#block[
  Sort $t \[ 1 . . n \]$ in ascending order Initialize $a n s arrow.l 0$,
  $l e f arrow.l n$

  $a n s$

]
=== 树上的最小顶点覆盖
<树上的最小顶点覆盖>
给出一种有效的贪心算法，该算法能在线性时间内找到一棵树中的一个最优顶点覆盖。

表示方案一采用定长数组存储每个结点的孩子结点，设给定一棵树$T$，其根结点为$T . r o o t$，阶数为$T . d e g r e e$。对于每个结点$x$，具有颜色属性$x . c o l o r$和包含$T . d e g r e e$个孩子结点指针的数组$x . c h i l d r e n$。该方案借鉴红黑树思想进行结点着色，规定每个结点非红即黑，所有空结点默认为黑色，且红色结点的所有孩子结点必须为黑色。在贪心算法实现中，首先将所有孩子结点为空结点的非空结点标记为红色，然后采用自底向上的遍历策略。具体实现采用方法一的后序遍历方式，其着色规则为：所有空结点保持黑色；对于非空结点，若其所有孩子结点均为黑色则将该结点着为红色，否则着为黑色。通过自底向上的后序遍历过程，当所有结点完成着色时，最终所有黑色结点的集合$C$即构成该树的最优顶点覆盖解。该方法的正确性依赖于树的后序遍历特性与颜色约束规则的结合，确保在多项式时间内获得满足条件的顶点覆盖。
