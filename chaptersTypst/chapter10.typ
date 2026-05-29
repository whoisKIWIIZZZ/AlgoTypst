


#import "@local/ysz_tools:0.1.0": *
#show: conf

= chapter10: 随机算法
<chapter10-随机算法>
== 导论
<导论>
+ 与确定性算法相比，随机算法所需运行时间或空间通常较小；

+ 随机算法易于理解和实现。

+ #strong[Las Vegas 算法]#footnote[Las Vegas 和 Monte Carlo
    不是一种算法的名称，而是对一类随机算法的特性的概括。不太可能为#strong[NP完全问题设计出多项式时间的随机算法]]：总是给出正确的解，或者无解

  通常需要分析#strong[算法的平均运行时间]，运行时间本身是一个随机变量。

  #strong[期望运行时间是输入规模的多项式]且#strong[总能给出正确答案]的随机算法称为#strong[有效]的拉斯维加斯算法，也称为
  #strong[ZPP 类算法]\(zero-error probabilistic polynomial
  time)算法，即零错误概率多项式时间随机算法。

+ #strong[Monte Carlo
    算法]：总是给出解，偶尔可能是错误解，可以通过多次运行原算法，且满足每次运行时随机选择都相互独立，使产生错误解的概率减到任意小。

  通常需要分析#strong[算法的出错概率]，总是在#strong[多项式时间内运行]且出错概率#strong[不超过
    1/3]的随机算法称为#strong[有效的\*]蒙塔卡洛型随机算法，也称为#strong[BPP
    类算法]\(bounded-error probabilistic polynomial
  time)，即错误概率有限的多项式时间随机算法。

  错误类型：

  - #strong[弃真型错误]：在求解一个判定问题时把本应该接受的输入误判为拒绝。

  - #strong[取伪型错误]：就是把本应该拒绝的输入误判为接受。

  根据是否同时出现两类错误，蒙特卡洛型算法又分为：

  + #strong[单侧错误的蒙特卡洛型算法]：在所有输入上，要么犯弃真的错误，要么犯取伪的错误，不同时出现两种不同的错误。

    - 有效的#strong[弃真型]单侧错误随机算法称为#strong[RP
        类算法]\(Randomized Polynomial-time)

    - 有效的#strong[取伪型]单侧错误随机算法称为#strong[coRP
        类算法]\(Complementary Randomized Polynomial-time, RP 的补类)

  + #strong[双侧错误]的蒙特卡洛型算法：在所有输入上可以同时出现两种不同的错误。

对于随机算法 A, 其在大小为 n 的一个实例 I
上的运行时间可能因不同次执行而异。因此，更自然的性能度量是 #strong[A
  在实例 I 上的期望运行时间]，也即算法 A 反复求解实例 I 所花费的平均时间。

- 对于确定算法，求解期望运行时间时，概率分布定义在#strong[输入]上

- 对于随机算法，求解期望运行时间时，概率分布定义在#strong[算法]上

期望时间：对于大小为 n 的特定输入I,
算法的期望时间就是在随机数的不同序列上的时间的平均:

$
  E T \( A \, I \) = sum_(upright("random sequence R")) upright("probility") \( R \) * upright("time") \( A \, I \, R \)
$

最坏情况下的期望时间：

$
  W \_ E T \( A \) = max_(upright("input I with size n")) \( upright("random sequence R") upright("probility") \( R \) * upright("time") \( A \, I \, R \) \)
$

== 随机算法举例
<随机算法举例>
这是一个很不错的讲解栏目：#link("https://www.luogu.com.cn/article/wegx023s")

=== 随机快速排序
<随机快速排序>
其实是在快速排序的基础上，增加了#strong[随机选取]的步骤。

#block[
  \(,,) \
  \
  (,, ) \
  (, +1, )

]
#block[
  \(,,)

  ̌$arrow.l$ (, ) #emph[interchange] #emph[and] \
  \
  \(,, ) \
  (,+1, ) \

]
该算法在最坏情况的运行时间仍然是$Theta \( n^2 \)$
，但这个最坏情况不是由于输入形式，而是由于随机数生成器每次非常不幸地选择了不好的划分元素，这种情况不大可能发生。算法的期望运行时间为$Theta \( n log n \)$,
是一个 ZPP 类算法

=== 随机选择
<随机选择>
#block[
  $arrow.l$ - + 1 \
  let = $floor.l p \/ 5 floor.r$.Divide into groups of 5 elements each. If
  5 doesn't divide , then discard the remaining elements. \
  Sort each of the groups individually and extract its median element. Let
  the set of medians be $M$ \
  $arrow.l$ ($M$, 1, , $floor.l$/2$floor.r$) Partition into three arrays:
  \
  $A_1 arrow.l { A \| A < m m }$
  ,$A_2 arrow.l { A \| A = m m }$,$A_3 arrow.l { A \| A > m m }$ \

]
#block[
  $v arrow.l$ \
  $x arrow.l A \[ v \]$ \
  Partition $A \[ l o w . . . h i g h \]$ into three arrays:
  $A_1 arrow.l { A \| A < x }$, $A_2 arrow.l { A \| A = x }$,
  $A_3 arrow.l { A \| A > x }$

]
在最坏情况下，随机数生成器在第$j$次迭代中选择第$j$小的元素，因此只丢弃一个元素。由于将$A$划分为$A_1$、$A_2$和$A_3$所需的比较次数正好为$n$，因此算法在最坏情况下进行的元素比较总数为
\$\$\\sum\_{i=1}^n i=\\frac{n(n+1)}{2}=\\Theta(n^2)\\\\
\$\$
设$C \( n \)$为对输入数组有$n$个元素时进行元素比较运算的#strong[期望次数]。由于随机选择的v可以等概率假设为$1 \, 2 \, . . . \, n$中的任何一个，因此根据$v < k$或$v > k$，有两种情况需要考虑。

- $v < k$: 剩余元素的数量为$n - v$\($v$右侧的元素数量为$n - v$)

- $v > k$: 剩余元素的数量为$v - 1$\($v$左侧的元素数量为$v - 1$)

因而有：
$
  C \( n \) = n + 1 / n sum_(v = 1)^n {C \( v - 1 \) & upright("if ") v < k \
                                       C \( n - v \) & upright("if ") v > k \
$

由数学归纳法，假设$C \( m \) lt.eq 4 m$对所有$m < n$成立，下证$C \( n \) lt.eq 4 n$:
$
  C \( n \) & lt.eq n + 1 / n sum_(v = 1)^n 4 dot.op max \( n - v \, v - 1 \) \
            & lt.eq n + 8 / n dot.op sum_(v = 1)^(n / 2) \( n - v \) \
            & lt.eq n + 8 / n dot.op frac(3 n^2, 8) \
            & = 4 n \
$
又由于每个元素至少被检查一次，因此$C \( n \) gt.eq n$，#strong[因此算法的期望运行时间是]$Theta \( n \)$，是
ZPP 类算法。

=== 多选问题
<多选问题>
设有$n$个元素的数组$A$,
并且设$K \[ 1 . . r \] \( 1 lt.eq r lt.eq n \)$是一个由1到$n$之间的$r$个正数构成的有序数组，即一个排序数组。

多选问题就是对于所有$i$，$1 lt.eq i lt.eq r$，选择A中的第$K \[ i \]$小的元素。假定$A \[ 1 . . . n \]$中所有元素各不相同。如果$r = 1$，该问题即为选择问题。如果$r = n$，该问题即为排列问题。

设$A \[ 1 . . n \] = \[ a_1 \, a_2 \, dots.h \, a_n \] \; K \[ 1 . . r \] = \[ k_1 \, k_2 \, dots.h \, k_r \]$，设中间排位为$k = k_(r / 2)$,可使用SELECT算法发现第$k$小的元素$a$.
接着根据$a$把$A$划分成两个子序列$A_1$和$A_2$，其中$A_1$中元素个数大于等于$a$，$A_2$中元素个数小于等于$a$。令$K_1 = \[ k_1 \, k_2 \, . . . k_(r / 2) \] \, K_2 = \[ k_(r / 2 + 1) \, k_(r / 2 + 2) \, . . . \, k_r \]$。
递归调用，一个关于$A_1$和$K_1$的递归调用，一个关于$A_2$和$K_2$的递归调用。

#block[
  multiselect($A$, $K$) \
  $r arrow.l \| K \|$ \

]
Multiselect算法的时间复杂度是$Theta \( n log r \)$.这是因为调用SELECT算法的复杂度是$Theta \( n \)$,
所以有递推式
$ T \( n \, r \) = Theta \( n \) + T \( n_1 \, r / 2 \) + T \( n_2 \, r / 2 \) \, n_1 + n_2 lt.eq n $

递归深度是$log r$，所以时间复杂度是$Theta \( n log r \)$.

将多选问题要寻找的元素称为靶标。
随机一致地挑选一个元素$a$（而不是通过SELECT精心选择），将数组$A$关于$a$分割成两部分：一部分元素小于$a$,
另一部分元素大于$a$ ​处理逻辑：​​

如果两部分均含有靶标，则递归调用算法继续求解;
否则，丢弃不含有靶标的部分，对含有靶标部分继续求解

该算法以概率$1 - O \( 1 / n \)$的时间复杂度为$O \( n log r \)$.
$r$个靶标的分配可以看作$r$次独立伯努利试验，其分布近似​二项分布$zws B \( r \, 1 \/ 2 \)$。
根据#emph[Hoeffding不等式]，靶标分配的偏离概率满足：
$ P (lr(|upright("左侧靶标数") - r / 2|) gt.eq epsilon.alt r) lt.eq 2 exp (- 2 epsilon.alt^2 r) $
当$r gt.eq c log n$时，此概率上界为$O \( 1 \/ n \)$。

=== 随机取样
<随机取样>
首先将所有$n$个元素标记为未选中。
接下来，重复以下步骤，直到选择了$m$个元素：

+ 生成一个介于$1$和$n$之间的随机数r

+ 如果$r$被标记为未选中，则将其标记为选中并将其添加到样本中

算法的期望运行时间$T \( n \) = Theta \( n \)$
如果$m > n / 2$，那么应该考虑反面，改为随机选择$n - m$个整数丢弃，将剩下的整数添加到样本中。

设第$k$次选择时已选中$k$个元素，则：

- 成功选中新元素的概率 $p_k = frac(n - k, n)$

- 失败（重复选中）的概率 $q_k = 1 - p_k = k / n$

根据几何分布，第$k + 1$个新元素的期望尝试次数为：
$ E_k = 1 / p_k = frac(n, n - k) $
每次尝试的时间成本为$Theta \( 1 \)$（仅需检查布尔数组$S$）。

$
  T \( n \) & = sum_(k = 0)^(m - 1) E_k dot.op Theta \( 1 \) \
            & = sum_(k = 0)^(m - 1) frac(n, n - k) \
            & = n (1 / n + frac(1, n - 1) + dots.h.c + frac(1, n - m + 1)) \
            & = n dot.op \( H_n - H_(n - m) \) quad upright("（调和数展开）")
$

利用调和数近似 $H_n approx ln n + gamma$：
$ T \( n \) approx n (ln n - ln \( n - m \)) = n ln (frac(n, n - m)) $

- 当$m = O \( n \)$时（如$m = sqrt(n)$）：$T \( n \) approx n dot.op m / n = Theta \( m \)$\($ln x approx x - 1$)

- 当$m = Theta \( n \)$时（如$m = n \/ 2$）：$T \( n \) = Theta \( n \)$

因此对于任意$m < n$，最坏情况下$T \( n \) = Theta \( n \)$。

=== 素数测试
<素数测试>
易知除2，3以外的所有素数都是$6 k plus.minus 1$的形式，因此可以用$6 k plus.minus 1 lt.eq sqrt(n)$来对$n$是否是素数进行测试。

+ #strong[随机抽取一个数] $a$（$1 lt.eq a < n$）；

+ #strong[检查等式]：验证涉及$a$和$n$的特定数论等式（与所选测试方法对应）。
  \
  若等式不成立，则：

  - $n$ 是合数（Composite）

  - $a$ 称为合数的#strong[证据]（Witness）

  - 测试终止

+ #strong[重复迭代]：返回步骤1，直到达到预设置信度。

现在我们先介绍幂运算：

#block[
  Let the binary digits of $n$ be $b_k \, b_(k - 1) \, dots.h \, b_0$ \
  $c arrow.l 1$ \
  c

]
如果每次乘法花费1个时间单元，算法的运行时间是$Theta \( log n \)$。但如果是任意大的整数，两数相乘的时间是$O \( log^2 n \)$，则算法的运行时间是$O \( log^3 n \)$。

利用费马定理：如果$n$是素数，那么对于所有的$a equiv.not 0 \( m o d med n \)$，都有$a^(n - 1) equiv 1 \( m o d med n \)$,如果通过$a$的测试，则成$n$是基2的伪素数，例如341.而对于小于100000的数中，只会有78个数计算出错，这是因为费马定理的逆并不正确。一类被称为#strong[卡迈克尔数]的合数$n$,它对于所有相对于$n$互素的正整数$a$均满足费马定理，他们在小于1e8的范围内只有255个。

引理：如果合数$n$不是一个卡迈克尔数，那么算法（随机选择$a$并验证费马定理）将检测出$n$为合数的概率至少是$1 / 2$.

若$n$是合数但非卡迈克尔数，则存在至少一个$b tack.t n$使得$b^(n - 1) equiv.not 1 \( m o d med n \)$，则定义集合
$ W = { a in { 1 \, 2 \, . . . \, n - 1 } \| a^(n - 1) equiv.not 1 \( m o d med n \) } $
而对于$W$在整数集$Z_n^(*)$上的补集$G$，易知$G$是$Z_n^(*)$的一个乘法子群，那么由拉格朗日定理知$\| G \|$整除$\| Z_n^(*) \| = phi.alt \( n \)$，所以$\| G \| lt.eq 1 / 2 phi.alt \( n \)$，所以$\| W \| gt.eq 1 / 2 phi.alt \( n \)$，引理得证。

再考虑Miller-Rabin算法, 设$n$为奇素数，则存在$q \, m$使得:
$ n - 1 = 2^q m \( q lt.eq 1 \) $ 构造序列：
$
  a^m \( m o d med n \) \, a^(2 m) \( m o d med n \) \, a^(4 m) \( m o d med n \) \, . . . \, a^(2^q m) \( m o d med n \)
$
由费马定理知，最后一项$a^(n - 1) equiv 1 \( m o d med n \)$.而如果$x^2 equiv 1 \( m o d med n \)$的根是$x = plus.minus 1$称为平凡根，其他根是不平凡的，如果存在非平凡根，那么一定是合数。

所以检测该序列中某项是1，那么前一项必须是$1$或者$n - 1$否则$n$是合数。

#block[
  $q arrow.l 0 \, m arrow.l n - 1$ \

  $a arrow.l$Random(2, $n - 1$) \
  $x_0 arrow.l$EXPMOD($a \, m \, n$)

]
每次测试出错(把合数判定为素数)概率至多是$1 / 2$,
这样我们重复运行$k$次，就可以将出错的概率降低到$2^(- k)$,
那么取$k = ceil.l log n ceil.r$，失败的概率不超过$2^(- ceil.l log n ceil.r) lt.eq 1 / n$,
而这就是#strong[Miller-Rabin算法].

=== 验证串的相等性
<验证串的相等性>
对于一个比特串$w$，设$I \( w \)$是$w$表示的一个整数，那么可以选一个素数$p$，这样得到一个指纹函数:
$ I_p \( x \) = I \( x \) \( m o d med x \) $
对于$I_p \( x \) = I_p \( y \)$，而$x eq.not y$的现象，我们称之为#strong[假匹配]。每次验证时重新选择$p$，并重复选择$p$,
可以增强$x = y$的可信度。

我们知道，设$pi \( n \)$是小于$n$的不同素数的个数，那么$pi \( n \)$趋近于$frac(n, ln n)$.
对于两个长度为$n$的串$x \, y$，如果发生假匹配，那么$p \| \( I \( x \) - I \( y \) \)$，所以其概率为：
$
  frac(\| { p lt.eq M \| p i s p r i m e a n d p \| I \( x \) - I \( y \) } \|, pi \( M \)) lt.eq frac(pi \( n \), pi \( M \))
$

#strong[关键观察]：假匹配发生时，素数 $p$ 必须满足
$p divides \( I \( x \) - I \( y \) \)$。由于 $x$ 和 $y$ 是长度为 $n$
的比特串，$I \( x \)$ 和 $I \( y \)$ 的绝对值不超过 $2^n - 1$，因此
$ \| I \( x \) - I \( y \) \| lt.eq 2^n - 1 . $
(这个结论需要在$n > 11$后成立，这是由切比雪夫函数完成估计的，最终$n$以内的素数的乘积的增长速率约为$e^(0.9 n)$，是高于$2^n - 1$这个速率的，所以该估计是正确的)

而如果取$M = n^2$，重复执行$k$次算法，这样最后概率最大是$\( 2 / n \)^k$.

=== 模式匹配
<模式匹配>
确定模式串是否出现在文本串中(假设都是0,1串)。利用随机算法比较模式指纹$I_p \( Y \)$和文本块$I_p \( X \( j \) \)$，让文本块的指纹要易于计算，最好还可以通过$X \( j \)$计算出$X \( j + 1 \)$

仿照上一题是思想，我们把这里的指纹就假定为选定的串对应的数的大小，那么有：
\$\$I\_p(X(j+1))=(2I\_p(X(j)) -2^mx\_j+x\_{j+m})(mod\~p)\\\\
\$\$

#block[
  在小于$M$的素数中随机选择素数$p$ \
  $j arrow.l 1$ \
  计算$I_p \( Y \) \, I_p \( X_j \)$ \

]
易知该算法的时间复杂度是$O \( m + n \)$

=== 货郎担问题
<货郎担问题>
假设有一个旅行商人要拜访n个城市，路径选择需满足以下限制：

+ 每个城市只能拜访一次；

+ 最终必须回到出发城市。

​优化目标​：选择总路程最短的路径

#block[
  $b e s t P a t h arrow.l \[ thin \]$
  $b e s t D i s t a n c e arrow.l oo$
  $p a t h arrow.l upright("随机排列") \( 1 \, 2 \, dots.h \, n \)$
  $d i s t a n c e arrow.l upright("计算路径总长度") \( p a t h \, D \)$

]
== 随机游走算法
<随机游走算法>
常用有限马尔科夫链来分析随机游走算法。

马尔可夫特性：随机过程在给定t时刻的状态为Xt，该过程的后续状态及其出现的概率与t之前的状态无关。也就是说，过程当前的状态包括了过程所有的历史信息，该过程的进一步发展完全由当前状态所决定，与当前状态之前的历史无关，这种性质也称为#strong[无后效性]或#strong[无记忆性]。

马尔科夫不等式：设$X$为只取非负的随机变量，数学期望$E \( X \) = mu$,
对于任意$epsilon > 0 \, P \( X gt.eq epsilon \) lt.eq mu / epsilon$

+ #strong[Integral method] (for continuous case):
  $
    E \( X \) = integral_0^oo x f \( x \) d x gt.eq integral_epsilon^oo x f \( x \) d x gt.eq integral_epsilon^oo epsilon f \( x \) d x gt.eq epsilon P \( X gt.eq epsilon \)
  $

+ #strong[Indicator method] (general): Define
  $Y = epsilon dot.op upright(bold(1))_({ X gt.eq epsilon })$, then:
  $ E \( Y \) = epsilon P \( X gt.eq epsilon \) lt.eq E \( X \) $

设一个离散的随机序列${ X_0 \, X_1 \, . . . }$，其中每个$X_i$都从有限集中取值，若它满足
$
  P \( X_(i + 1) = x_(i + 1) \| X_i = x_i \, X_(i - 1) = x_(i - 1) \, . . . \, X_0 = x_0 \) = P \( X_(i + 1) = x_(i + 1) \| X_i = x_i \) = p_(x_i \, x_(i + 1))
$

这称之为#strong[有限马尔科夫链]

对于有限马氏链，不妨设$X_t$取值的状态空间为${ 0 \, 1 \, dots.h \, n }$，于是$p_(i \, j)$（从状态$i$转移到状态$j$的概率）可组成一个$n + 1$阶方阵
$ P = \[ p_(i \, j) \] \, $
称为#strong[一步转移矩阵]，每一行元素之和等于$1$。

设$p_i \( t \)$表示在时刻$t$处于状态$i$的概率，则
$
  p_i \( t \) = p_0 \( t - 1 \) p_(0 i) + p_1 \( t - 1 \) p_(1 i) + dots.h.c + p_(n - 1) \( t - 1 \) p_(\( n - 1 \) i) + p_n \( t - 1 \) p_(n i)
$

设$bold(p) \( t \)$表示向量$\( p_0 \( t \) \, p_1 \( t \) \, dots.h \, p_n \( t \) \)$，有
$ bold(p) \( t \) = bold(p) \( t - 1 \) P $

对于任意$m$，定义$m$步转移矩阵
$ P^(\( m \)) = #scale(x: 120%, y: 120%)[\[] p_(i \, j)^(\( m \)) #scale(x: 120%, y: 120%)[\]] \, $
其中 $ p_(i \, j)^(\( m \)) = P \( X_(t + m) = j divides X_t = i \) . $
因此， \$\$P^{(m)} = P^m,\\\\
\\boldsymbol{p}(t + m) = \\boldsymbol{p}(t) P^{m}.\$\$

== 二元布尔可满足问题
<二元布尔可满足问题>
#block[
  随机初始化赋值$sigma$：对每个变元$x_i$随机赋$upright("True")$或$upright("False")$

]
#strong[定理：]
若输入公式是不可满足的，则上述随机游走算法正确宣布不可满足；若输入公式是可满足的，则上述算法以
$1 - 1 / 2^m$ 概率找到可满足赋值。

定义马尔可夫链${ Y_0 \, Y_1 \, Y_2 \, dots.h.c }$如下： $                                  Y_0 & = X_0 \
    P \( Y_(t + 1) = 1 \| Y_t = 0 \) & = 1 \
P \( Y_(t + 1) = j + 1 \| Y_t = j \) & = 1 / 2 \
P \( Y_(t + 1) = j - 1 \| Y_t = j \) & = 1 / 2 quad \( j > 0 \) $

显然有：
$
  P \( Y_(t + 1) = j + 1 \| Y_t = j \) & = 1 / 2 gt.eq P \( X_(t + 1) = j + 1 \| X_t = j \) \
  P \( Y_(t + 1) = j - 1 \| Y_t = j \) & = 1 / 2 gt.eq P \( X_(t + 1) = j - 1 \| X_t = j \)
$

从任意状态出发，$Y_t$比$X_t$花费更长的期望时间进入状态$n$。因此$Y_t$进入状态$n$的时间作为算法期望运行时间的上界。

设$h_j$表示从状态$j$到状态$n$的期望运行时间，则有： $ h_n & = 0 \
h_0 & = h_1 + 1 \
h_j & = frac(h_(j + 1) + 1, 2) + frac(h_(j - 1) + 1, 2) \, quad 0 < j < n $

由归纳法可证，对于所有$j$，有： $ h_j lt.eq n^2 - j^2 lt.eq n^2 $

因此有：
$
  E \[ X upright("从") X_0 upright("到达") n upright("的时间") \] lt.eq E \[ Y upright("从") Y_0 upright("到达") n upright("的时间") \] lt.eq n^2
$

取$epsilon = 2 n^2$，根据马尔可夫不等式，则有：
$ P \( X upright("从") X_0 upright("到达") n upright("的时间") gt.eq 2 n^2 \) lt.eq frac(n^2, 2 n^2) = 1 / 2 $

#strong[证明：]

- #strong[不可满足情形：]
  显然，算法无法找到可满足赋值，因此正确宣布不可满足。

- #strong[可满足情形：]
  算法有可能找不到可满足赋值而出错，下面证出错概率为 $1 / 2^m$。

+ #strong[汉明距离定义]：设$sigma^(*)$为最优赋值，当前赋值$sigma$与$sigma^(*)$的汉明距离$d \( sigma \, sigma^(*) \)$表示两者取值不同的变量个数。

+ #strong[改进概率]：对每个不满足子句，至少以$1 / 2$概率减少$d \( sigma \, sigma^(*) \)$（因子句最多2个文字）。

+ #strong[收敛分析]：经过$2 n^2 m$步迭代，未到达$sigma^(*)$的概率：
  $ P \( upright("失败") \) lt.eq (1 - frac(1, 2 n))^(2 n^2 m) approx e^(- n m) lt.eq 1 / 2^m $

== 本章作业
<本章作业>
=== 优惠劵收集
<优惠劵收集>
有$n$种优惠券，每种优惠券数目不限。每次实验随机抽取一张优惠券，优惠券来自$n$种中任何一种的概率均等。计算需要多少次实验才能使得收集的优惠券包含$n$种中每一种至少一张。

设$X_i$表示在已收集$i - 1$种优惠券后，首次抽到第$i$种新优惠券所需的次数（$i = 1 \, 2 \, dots.h \, n$）。

在已收集$k$种优惠券时，抽到新优惠券的概率为$p_k = frac(n - k, n)$，因此$X_(k + 1)$服从参数为$p_k$的几何分布，其期望为：
$ E \( X_(k + 1) \) = 1 / p_k = frac(n, n - k) $

集齐所有$n$种优惠券的总次数$T$为各阶段次数之和：
$ T = X_1 + X_2 + dots.h + X_n $ 总期望为：
$ E \( T \) = sum_(k = 0)^(n - 1) frac(n, n - k) = n sum_(k = 1)^n 1 / k = n H_n $
当$n$较大时，$H_n approx ln n + gamma$。因此：
$ E \( T \) approx n ln n + gamma n $ 集齐$n$种优惠券的平均实验次数为：
$ E \( T \) = n H_n = n (1 + 1 / 2 + dots.h + 1 / n) $
对于大$n$，可近似为$n ln n + gamma n \, upright("其中") gamma approx 0.577$，

=== 用公平硬币随机序列生成
<用公平硬币随机序列生成>
假定你有一枚公平硬币，请设计一个有效的随机算法用来生成整数$1 \, 2 \, . . . \, n$的一个随机排列。并分析你的算法的时间复杂性.

#block[
  初始化数组$A$：$A \[ i \] arrow.l i$ 对 $i = 1$到$n$

]
考虑$i$次枚举后才找到
\$\$\\sum\_{i=1}^\\infty q^i=\\frac{q}{1-q}=1-p\\\\
解得q=1-\\frac{1}{2-p}\\\\
\$\$

在最优情况下，所有的$j$都被接受，最优时间复杂度是
\$\$\\begin{equation\*}
\\sum\_{i=2}^n\\lceil\\log\_2i\\rceil\\triangleq C\_{opt}(n)\\\\
\\end{equation\*}\$\$

有：

$ C_(o p t) \( n \) lt.eq sum_(i = 2)^n log_2 n = O \( n log n \) $

也有：(此处省略分部积分的步骤)
$
  C_(o p t) \( n \) gt.eq sum_(i = 2)^n log_2 i = sum_(i = 2)^n integral_(i - 1)^i log_2 i d x gt.eq sum_(i = 2)^n integral_(i - 1)^i log_2 x d x = integral_1^n log_2 x d x = O \( n log n \)
$
因此由夹逼定理有：$C_(o p t) \( n \) = O \( n log n \)$

下面考虑最坏情况$C_(w o r) \( n \)$

对于$i$情况下单次$j$的取值，拒绝概率为：

$
  P_(r e j e c t) \( i \) = frac(2^(ceil.l log_2 i ceil.r) - i, 2^(ceil.l log_2 i ceil.r)) = 1 - i / 2^(ceil.l log_2 i ceil.r) eq.delta p_i
$

考虑$i$情况下$k$次$j$的取值被拒绝的概率是$p_i^k$，每次被拒绝都会多进行$ceil.l log_2 i ceil.r$次硬币投掷实验，因此$k$次取值后产生的次数为：$p_i^k dot.op k ceil.l log_2 i ceil.r$，因此$i$情况下的总投掷次数为：（跳过等差乘等比级数的数学推导）
$
  w_i = sum_(k = 1)^oo p_i^k dot.op k ceil.l log_2 i ceil.r = frac(p_i \( 1 + p_i \), \( 1 - p_i \)^2) ceil.l log_2 i ceil.r = frac(\( 2^(ceil.l log_2 i ceil.r) - i \) \( 2^(ceil.l log_2 i ceil.r + 1) - i \), i^2) lt.eq frac(i dot.op 3 i, i^2) = 3
$
因为拒绝而多出的总次数为：
$ C_(p e n a l t y) \( n \) = sum_(i = 2)^n w_i lt.eq 3 n = O \( n \) $
所以最坏时间复杂度为：
\$\$C\_{wor}(n)=C\_{penalty}(n)+C\_{opt}(n)=O(n\\log n)\\\\
\$\$ 综上，该算法的时间复杂度是$O \( n log n \)$
(当然可以改成如果$j > i$，就$j % = i$，这样也就省了这步计算了)

=== 矩阵互逆
<矩阵互逆>
给定两个$n times n$方阵$A$和$B$，判定它们是否互逆（即$A B = I$）。算法基于蒙特卡罗方法，通过随机采样验证$A B$矩阵元素的性质：

- 对角线元素应为$1$（允许误差$epsilon.alt$）

- 非对角线元素应为$0$（允许误差$epsilon.alt$）

#block[
]
- #strong[时间复杂度]：$O \( T dot.op n \)$

  - 每次采样需要$O \( n \)$时间计算矩阵元素

  - 共进行$T$次采样

- #strong[空间复杂度]：$O \( 1 \)$（仅需存储临时变量）

=== 三元可满足问题
<三元可满足问题>
请设计随机游走算法求解三元可满足问题，并分析算法的期望运行时间。

#block[
  随机初始化变量赋值 $upright(bold(x)) = \( x_1 \, dots.h \, x_n \)$

]
- #strong[递推关系]（3文字子句）：
  $ h_j = 2 / 3 h_(j + 1) + 1 / 3 h_(j - 1) + 1 $

- #strong[特征根]：
  $ r_1 = 1 \, med r_2 = - 1 / 2 arrow.r.double.long h_j approx 3^j $

- #strong[指数下界]： $ E \[ T \] gt.eq 3^n - 1 = Omega \( 3^n \) $

=== 拉斯维加斯型与蒙特卡洛型的期望运行时间推导关系
<拉斯维加斯型与蒙特卡洛型的期望运行时间推导关系>
设$A$是一个蒙特卡洛随机算法，满足：

- 期望运行时间不超过$T \( n \)$

- 返回正确解的概率为$p \( n \)$

- 任何解的正确性可在$T' \( n \)$时间内验证

我们构造拉斯维加斯算法$A'$如下：

+ 运行$A$（耗时$lt.eq T \( n \)$）

+ 验证解的正确性（耗时$lt.eq T' \( n \)$）

+ 若正确则返回解, 否则重复验证

$ E \[ upright("时间") \] lt.eq frac(T \( n \) + T' \( n \), p \( n \)) $

期望时间公式成立因为：
$
  E \[ upright("总时间") \] = sum_(k = 1)^oo [\( 1 - p \( n \) \)^(k - 1) p \( n \) dot.op k \( T \( n \) + T' \( n \) \)] = frac(T \( n \) + T' \( n \), p \( n \))
$
该转换在保证结果正确性的前提下，仅增加了多项式时间开销
