#import "@local/ysz_tools:0.1.0": *
#show: conf.with(sidebar: false)

= chapter10: 随机算法
<chapter10-随机算法>

== 引言
<引言>

=== 随机化算法
<随机化算法>

随机化算法把"对于所有合理的输入都必须给出正确的输出"这一求解问题的条件放宽，将随机性的选择注入到算法中，在算法执行某些步骤时可以随机地选择下一步该如何进展，同时允许结果以较小的概率出现错误，并以此为代价获得算法运行时间的大幅度减少。

#strong[随机化算法优点]
- 与确定性算法相比，随机算法所需运行时间或空间通常较小；
- 随机算法易于理解和实现。

=== 两类随机算法及其关系
<两类随机算法>

#strong[Las Vegas算法（拉斯维加斯算法）]#footnote[Las Vegas 和 Monte Carlo 不是一种算法的名称，而是对一类随机算法的特性的概括。不太可能为 NP 完全问题设计出多项式时间的随机算法]
- 总是给出正确的解，或者无解。
- 运行时间本身是一个随机变量，通常需要分析算法的平均运行时间。
- 期望运行时间是输入规模的多项式且总能给出正确答案的随机算法称为#strong[有效的拉斯维加斯算法]，也称为#strong[ZPP类算法]（zero-error probabilistic polynomial time），即零错误概率多项式时间随机算法。

#strong[Monte Carlo算法（蒙特卡罗算法）]
- 总是给出解，但偶尔可能是错误解。
- 可以通过多次运行原算法，且满足每次运行时随机选择都相互独立，使产生错误解的概率减到任意小。
- 运行时间和出错概率都是随机变量。
- 总是在多项式时间内运行且出错概率不超过$1/3$（可压到任意小）的随机算法称为#strong[有效的蒙特卡罗算法]，也称为#strong[BPP类算法]（bounded-error probabilistic polynomial time），即错误概率有限的多项式时间随机算法。

错误类型：
- #strong[弃真型错误]：在求解判定问题时把本应接受的输入误判为拒绝。
- #strong[取伪型错误]：把本应拒绝的输入误判为接受。

根据是否同时出现两类错误，Monte Carlo算法又分为：
+ #strong[单侧错误的Monte Carlo算法]：在所有输入上只犯弃真或只犯取伪的错误。
  - 有效的#strong[弃真型]单侧错误随机算法称为#strong[RP类算法]（Randomized Polynomial-time）
  - 有效的#strong[取伪型]单侧错误随机算法称为#strong[coRP类算法]（Complementary Randomized Polynomial-time, RP的补类）
+ #strong[双侧错误]的Monte Carlo算法：在所有输入上可以同时出现两种不同的错误。

Las Vegas算法与Monte Carlo算法的对比：

#table(
  columns: 3,
  [比较项目], [Las Vegas], [Monte Carlo],
  [规律], [采样越多越有可能找到最优解], [采样越多越逼近最优解],
  [例子], [从一串钥匙中试出能开锁的钥匙], [从不透明的苹果筐中挑最大的苹果],
  [策略], [尽量找最好的，但不保证能找到（除非全枚举）], [尽量找好的，但不保证是最好],
  [适用情景], [要求必须给出最优解], [要求在有限采样内必须给出一个解，但不要求最优],
)

=== 随机算法的时间复杂度分析
<时间复杂度分析>

对于随机算法，在一个大小为$n$的固定实例$I$上的运行时间，一次和另一次的执行可能不相同。因此，一种更自然的度量是算法$A$在固定实例$I$上的#strong[期望运行时间]——用算法$A$反复求解实例$I$的平均时间。

- 对于#strong[确定性算法]，求解期望运行时间时，概率分布定义在#strong[输入]上。
- 对于#strong[随机算法]，求解期望运行时间时，概率分布定义在#strong[算法]（随机数序列）上。

#remark[
  #strong[核心区别]：确定性算法对输入取平均（假设均匀分布），随机算法对随机数取平均（输入固定）。因此随机算法的复杂度分析不依赖输入分布假设。
]

#strong[预期时间（Expected Time）]：
对于大小为$n$的特定输入$I$，算法的预期时间就是在不同随机数序列上得到的平均时间：
$
  upright("ET")(A, I) = sum_("random sequence " R) "probability"(R) * "time"(A, I, R)
$

#strong[最坏情况预期时间（Worst-case Expected Time）]：
算法的最坏情况预期时间是所有长度为$n$的输入的预期时间的最大值：
$
  upright("W_ET")(A) = max_("input " I " with size " n) [
    sum_("random sequence " R) "probability"(R) * "time"(A, I, R)
  ]
$

== 随机算法举例
<随机算法举例>

这是一个很不错的讲解栏目：#link("https://www.luogu.com.cn/article/wegx023s")

=== 素数测试
<素数测试>

==== 问题背景
<素数测试-背景>

直观的试除法（用$2$到$sqrt(n)$的数去除）效率极低——因数分解远难于素性测试本身。随机算法的突破口：找#strong[合数的证据（witness）]而非直接分解因子。

==== 模幂运算：ExpMod
<ExpMod>

#algorithm[ExpMod 模幂运算][
  *输入*：正整数 $a, m, n$（$m lt.eq n$）
  *输出*：$a^m (mod n)$

  算法在每次平方或乘法之后取 $n$ 的模，而非先算 $a^m$ 再取模。

  ```text
  设 m 的二进制数字为 b_k, b_{k-1}, ..., b_0
  c ← 1
  for j ← k downto 0:
      c ← c^2 (mod n)
      if b_j = 1 then c ← a·c (mod n)
  return c
  ```

  如果每次乘法花费1个时间单元，运行时间为 $Theta(log n)$。但若处理任意大整数，两数相乘为 $O(log^2 n)$，则总运行时间为 $O(log^3 n)$。
]

==== 费马小定理
<费马小定理>

#strong[定理]：如果$n$是素数，那么对于所有$a not 0 (mod n)$，有
$
  a^(n-1) equiv 1 (mod n)
$
#strong[逆否命题]：若存在$a$使得$a^(n-1) not 1 (mod n)$，则$n$一定是合数（$a$称为$n$的见证者）。
但#strong[费马定理的逆不成立]——存在合数$n$满足$a^(n-1) equiv 1 (mod n)$，称为基$a$的#strong[伪素数]。

==== PTEST1：固定底数测试
<PTEST1>

#algorithm[PTEST1 基2费马测试][
  *输入*：正奇整数 $n gt.eq 5$
  *输出*：若 $n$ 是素数则返回 `prime`（可能），否则返回 `composite`（确定）

  ```text
  if ExpMod(2, n-1, n) ≡ 1 (mod n) then return prime   {可能}
  else return composite                                 {确定}
  ```
]

缺点：存在基2的伪素数。例如$341 = 11 times 31$满足$2^340 equiv 1 (mod 341)$。在4到2000之间的合数中，仅对341, 561, 645, 1105, 1387, 1729, 1905这7个误判。小于$100,000$的数中仅78个出错，最大的是$93,961 = 7 times 31 times 433$。

==== PTEST2：随机底数的费马测试
<PTEST2>

#algorithm[PTEST2 随机底费马测试][
  *输入*：正奇整数 $n gt.eq 5$
  *输出*：若 $n$ 是素数则返回 `prime`（可能），否则返回 `composite`（确定）

  ```text
  a ← random(2, n-2)
  if ExpMod(a, n-1, n) ≡ 1 (mod n) then return prime   {可能}
  else return composite                                 {确定}
  ```
]

#strong[引理]：如果$n$不是Carmichael数，则PTEST2检测出$n$为合数的概率至少为$1/2$。

证明思路：设$Z_n^*$为小于$n$且与$n$互素的正整数集合，定义
$
  F_n = { a in Z_n^* | a^(n-1) equiv 1 (mod n) }
$
若$n$既不是素数也不是Carmichael数，则$F_n$是$Z_n^*$的真子群。由拉格朗日定理，$|F_n|$整除$|Z_n^*| = phi(n)$，从而$|F_n| lt.eq 1/2 |Z_n^*|$。即$Z_n^*$中至少有一半的元素可作为合数的见证者。

==== 卡迈克尔数（Carmichael数）
<Carmichael数>

#definition[卡迈克尔数][
  一类特殊的合数——它们对所有与 $n$ 互质的 $a$ 均满足费马定理 $a^(n-1) equiv 1 (mod n)$。因此用纯费马测试无法检出。

  最小的Carmichael数：$561 = 3 times 11 times 17$，$1105 = 5 times 13 times 17$，$1729 = 7 times 13 times 19$，$2465 = 5 times 17 times 29$。
  在小于 $10^8$ 的范围内仅有255个。但已证明存在无穷多个Carmichael数。
]

==== PTEST3：非平凡平方根检测
<PTEST3>

PTEST3的核心思想是：在素数模$n$下，方程$x^2 equiv 1 (mod n)$的#strong[唯一解]只有$x equiv 1$和$x equiv -1 (mod n)$（即$n-1$）。这两个解称为#strong[平凡根]。任何其他的根都是#strong[非平凡平方根]，其存在是$n$为合数的#strong[铁证]。

#definition[非平凡平方根][
  若 $x^2 equiv 1 (mod n)$ 但 $x not equiv plus.minus 1 (mod n)$，则 $x$ 称为 $1$ 的*非平凡平方根*。\
  #strong[逆否命题]：存在非平凡平方根 -> $n$ 是合数。
]

算法的构造：将$n-1$分解为$m dot.c 2^q$（$m$为奇数，$q gt.eq 1$）。然后构造序列：
$
  a^m (mod n), ; a^(2m) (mod n), ; a^(4m) (mod n), ; dots.c, ; a^(2^q m) (mod n)
$
注意$a^(2^q m) = a^(n-1)$，因此第$q$步正好就是$a^(n-1) mod n$——费马定理的检查点。

#algorithm[PTEST3 非平凡平方根检测][
  *输入*：正奇整数 $n$，分解参数 $q, m$（满足 $n-1 = 2^q m$，$m$ 奇数）
  *输出*：若 $n$ 是素数则返回 `prime`（可能），否则返回 `composite`（确定）

  ```text
  a ← random(2, n-1)
  x0 ← ExpMod(a, m, n)              // x0 = a^m (mod n)
  for i ← 1 to q:                   // 反复平方 q 次
      xi ← (x_{i-1})^2 (mod n)
      if xi = 1 and x_{i-1} ≠ 1 and x_{i-1} ≠ n-1 then
          return composite           {确定}  // 非平凡平方根，铁证！
  if x_q ≠ 1 then
      return composite               {确定}
  return prime                       {可能}
  ```
]

#table(
  columns: 4,
  [场景], [$x_(i-1)$], [$x_i = x_(i-1)^2$], [结论],
  [正常①], [$1$], [$1^2 = 1$], [✅ 前一步已是$1$，正常],
  [正常②], [$n-1 (= -1)$], [$( -1)^2 = 1$], [✅ 素数允许$-1 arrow.r 1$],
  [合数铁证], [既不是$1$也不是$n-1$], [某数的平方$equiv 1$], [#strong[❌ 找到了非平凡平方根，$n$必为合数]],
)

#remark[
  关于参数 $q$ 的作用：因 $n-1 = m dot.c 2^q$，故第 $q$ 步 $x_q = a^(2^q m) = a^(n-1) mod n$，后续再平方无意义（$1^2 = 1$ 死循环）。PTEST3 在路径的每个平方步骤设置哨兵，比只检查终点 $a^(n-1)$ 的 PTEST2 多了一层非平凡平方根检测，因此能绕过 Carmichael 数。
]

==== Miller-Rabin 算法（PrimalityTest）
<Miller-Rabin>

PTEST3单次测试可能出错（把合数判为素数）的概率至多为$1/2$。通过重复独立测试$k$次，错误概率降至$2^(-k)$。

#algorithm[PrimalityTest Miller-Rabin 算法][
  *输入*：正奇整数 $n gt.eq 5$
  *输出*：若 $n$ 是素数则返回 `prime`，否则返回 `composite`

  1. 分解 $n-1 = m dot.c 2^q$，$m$ 为奇数
  2. $k ← ceil(log n)$
  3. 重复 $k$ 次（每次独立随机选 $a$）：
     调用 PTEST3$(n, q, m)$，若返回 `composite` 则直接输出
  4. 若 $k$ 次均未检出：输出 `prime`（可能）

  ```text
  q ← 0; m ← n-1
  repeat                        // 查找 q 和 m
      m ← m / 2
      q ← q + 1
  until m 为奇数
  k ← ⌈log n⌉
  for i ← 1 to k:
      a ← random(2, n-2)
      x ← ExpMod(a, m, n)
      if x = 1 then continue     // 本轮回合通过
      for j ← 0 to q-1:
          if x ≡ n-1 (mod n) then break  // 本轮回合通过
          x ← x^2 (mod n)
      end for
      if j = q then return composite     // 没找到 -1
  return prime
  ```
]

#strong[错误概率]：取$k = ceil.l log n ceil.r$，失败概率
$
  2^(-ceil.l log n ceil.r) lt.eq 1/n
$
即算法以至少$1 - 1/n$的概率给出正确回答。当$n$足够大时，错误概率可忽略。

#strong[算法层次关系]：

#block[
  PTEST1 $subset$ PTEST2 $subset$ PTEST3 $subset$ PrimalityTest \
  \
  PTEST1：固定底$a=2$的费马测试（受限于基2伪素数）\
  PTEST2：随机底的费马测试（受限于Carmichael数）\
  PTEST3：核心子程序，反复平方检测非平凡平方根（单次错率$lt.eq 1/2$）\
  PrimalityTest：PTEST3重复$ceil.l log n ceil.r$次（总错率$lt.eq 1/n$）
]

#strong[时间复杂度]：总时间$O(log^4 n)$（$k = O(log n)$轮，每轮模幂$O(log^3 n)$）。

=== 测试串的相等性
<验证串的相等性>

==== 问题与指纹思想
<指纹-问题>

#problem[串相等性测试][
  A组有串 $x$，B组有串 $y$，通过一条窄信道通信。要判断 $x = y$ 是否成立。\
  朴素方案需传输整个串，带宽浪费严重。指纹方案只传一个短指纹。
]

#strong[指纹函数]：选一个素数$p$，定义
$
  I_p(x) = I(x) mod p
$
其中$I(x)$是比特串$x$表示的整数。若$p$不太大，$I_p(x)$只需$O(log p)$比特传输。

==== 协议流程
<指纹协议>

#algorithm[StringEqualityTest 串相等性测试][
  *输入*：A 持有串 $x$，B 持有串 $y$
  *输出*：$x$ 和 $y$ 是否相等

  ```text
  1. A 从小于 M 的素数集中随机选取 p
  2. A 将 p 和 I_p(x) 发送给 B
  3. B 检查 I_p(x) = I_p(y) 是否成立
     若相等，则假定 x = y；否则得出 x ≠ y
  ```

  若 $I_p(x) != I_p(y)$ 则 *确定* $x != y$；若 $I_p(x) = I_p(y)$ 则可能发生#strong[假匹配]。
]

==== 假匹配与失败概率
<指纹-假匹配>

若$x eq.not y$但$I_p(x) = I_p(y)$，即$p$整除$I(x) - I(y)$，称为#strong[假匹配]。

由#strong[素数定理]：$pi(x)$（不超过$x$的素数个数）满足
$
  pi(x) ~ frac(x, ln x)
$
即素数密度约$1/ln x$。

设串$x$和$y$的长度均为$n$比特。对随机选定的素数$p lt.eq M$，假匹配概率为：
$
  Pr["失败"] = frac(|{ p "is a prime" lt.eq M \&\& p | (I(x) - I(y)) }|, pi(M)) lt.eq frac(pi(n), pi(M))
$
取$M = 2n^2$，则
$
  Pr["失败"] lt.eq frac(pi(n), pi(2n^2)) approx frac(n / ln n, 2n^2 / ln(2n^2)) = frac(ln(2n^2), 2n ln n) approx frac(1, n)
$

重复算法$k$次（每次独立选择新素数$p$）：
$
  Pr["失败"] lt.eq (frac(1, n))^k
$
取$k = ceil.l log log n ceil.r$时，失败概率降至$n^(-ceil.l log log n ceil.r)$。

=== 模式匹配
<模式匹配>

==== 滚动哈希
<滚动哈希>

将文本$X = x_1 x_2 dots.c x_n$与模式$Y = y_1 y_2 dots.c y_m$（$m lt.eq n$）做匹配。利用随机算法比较模式指纹$I_p(Y)$和文本块指纹$I_p(X(j))$（其中$X(j) = x_j dots.c x_(j+m-1)$）。

将子串视为二进制表示的整数，则从窗口$j$滑动到窗口$j+1$只需三步：
1. 去掉最高位$x_j dot.c 2^(m-1)$
2. 整体左移一位（乘以2）
3. 加上新低位$x_(j+m)$

约去模$p$后得滚动哈希公式：
$
  I_p(X(j+1)) equiv (2 dot.c I_p(X(j)) - 2^m x_j + x_(j+m)) "mod" p
$
记$W_p = 2^m mod p$（只需预计算一次）：
$
  I_p(X(j+1)) equiv (2 I_p(X(j)) - W_p x_j + x_(j+m)) "mod" p
$

==== 算法流程
<模式匹配-流程>

#algorithm[PatternMatching 随机化模式匹配][
  *输入*：文本串 $X$（长度 $n$），模式 $Y$（长度 $m$），$m lt.eq n$
  *输出*：若 $Y$ 在 $X$ 中则返回第一个位置，否则返回 $0$

  ```text
  从小于 M 的素数集中随机选取 p
  计算 W_p = 2^m (mod p), I_p(Y), I_p(X(1))
  j ← 1
  while j ≤ n - m + 1:
      if I_p(X(j)) = I_p(Y) then return j    {可能}
      用滚动哈希公式计算 I_p(X(j+1))
      j ← j + 1
  return 0                                   {确定，Y 不在 X 中}
  ```
]

==== 复杂度与错误分析
<模式匹配-分析>

- 计算$W_p, I_p(Y), I_p(X(1))$：$O(m)$
- 每个后续窗口：$O(1)$（常数次加减模运算）
- 总时间：$O(n + m)$

假匹配概率：若$Y eq.not X(j)$但$I_p(Y) = I_p(X(j))$，则$p$整除
$
  product_{{j mid Y eq.not X(j)}} |I(Y) - I(X(j))|
$
该乘积不超过$2^(m n)$，整除它的素数个数不超过$pi(m n)$。取$M = 2 m n^2$时：
$
  Pr["假匹配"] lt.eq frac(pi(m n), pi(2 m n^2)) approx frac(1, n)
$
#strong[关键结论]：假匹配概率仅与文本长度$n$有关，与模式长度$m$无关。

==== 转换为Las Vegas算法
<模式匹配-LV>

当指纹匹配时，额外进行一次逐字符确认（$O(m)$时间）。期望时间仍为$O(n + m)$。

=== 货郎担问题（TSP）
<货郎担问题>

==== 随机采样算法（Monte Carlo）
<TSP-随机采样>

#algorithm[TSP 随机采样][
  *输入*：城市数 $n$，距离矩阵 $D$
  *输出*：经过所有城市的最短回路（不一定最优，Monte Carlo 式输出）

  ```text
  bestPath ← [], bestDistance ← ∞, iteration ← 100000
  path ← 随机排列 [1, 2, ..., n]
  distance ← 计算 path 的总长度
  while iteration > 0:
      if distance < bestDistance:
          bestPath ← path
          bestDistance ← distance
      path ← 重新生成随机路径
      distance ← 计算 path 的总长度
      iteration ← iteration - 1
  return bestPath, bestDistance              {可能找到了最优解}
  ```
]

这是一个#strong[Monte Carlo算法]：一定有输出，但未必是最优解。随着采样次数增加，找到最优的概率增大。

#strong[局限性]：$n$个城市的哈密顿回路总数为$(n-1)!/2$。采样10万次时，$n=10$时尚可覆盖约55%，但$n=15$时空间可达约870亿，采样几乎无法覆盖。因此纯随机采样在大规模TSP上不实用。实际中常用模拟退火、遗传算法、随机局部搜索等更智能的随机化策略。

=== 随机游走算法
<随机游走算法>

==== 基本概念
<随机游走-概念>

随机游走（Random Walk）由Karl Pearson于1905年提出，源于物理学中的布朗运动模型。在计算机科学中，随机游走用于在图上进行关系传递分析。

基本规则：从一个或一系列顶点开始遍历一张图。在任意顶点，遍历者以概率$1-a$游走到一个邻居，以概率$a$随机跳转到图中的任意顶点（$a$称为跳转概率）。反复迭代后概率分布收敛于平稳分布。著名应用：PageRank算法。

==== 一维有边界随机游走的数学推导
<随机游走-一维推导>

#problem[一维有边界随机游走][
  *设定*：一维数轴，初始位置 $x = n$，左右吸收壁 $x = 0$ 和 $x = w$（$0 lt.eq n lt.eq w$）。每单位时间向左/向右移动1步的概率均为 $1/2$，到达吸收壁后停止。

  定义 $S_n$：从位置 $n$ 出发最终落入左边界 $x = 0$ 的概率。
  边界条件：$S_0 = 1$（已在左边），$S_w = 0$（在右边不可能落入左边）。
]

对中间状态$0 < n < w$，由全概率公式：
$
  S_n = 1/2 S_(n-1) + 1/2 S_(n+1)
$

两边乘以2并移项：
$
  2 S_n = S_(n-1) + S_(n+1)
$
$
  S_(n+1) - S_n = S_n - S_(n-1)
$

相邻差为常数，$S_n$是等差数列。设$S_(n+1) - S_n = k$，则
$
  S_n = k n + S_0
$
代入$S_0 = 1, S_w = 0$得$k = -1/w$，因此：
$
  S_n = 1 - frac(n, w) = frac(w - n, w)
$

==== 单边界情况：酒鬼必掉悬崖
<随机游走-单边界>

将右边界推至无穷远$w arrow.r +oo$：
$
  S_n = lim_(w arrow.r +oo) frac(w - n, w) = 1
$

从任何有限位置出发，最终落入左边界的概率为1。#strong[酒鬼失足问题]：酒鬼离悬崖仅一步之遥，每步前后各$1/2$，最终必定掉下悬崖。#strong[赌徒输光问题]：在公平赌博中，赌徒面对庄家无穷资本时，迟早会输光所有赌金。

==== 求解函数全局最优
<随机游走-函数优化>

#algorithm[随机游走求函数全局最优][
  *输入*：多元函数 $f(x_1, x_2, ..., x_n)$，初始点 $x$，初始步长 $lambda$，精度 $epsilon$，迭代上限 $N$
  *输出*：函数最小值的近似位置

  ```text
  while λ > ε:
      k ← 1
      while k < N:
          生成 (-1,1) 之间的 n 维随机向量 u
          标准化：u' = u / ‖u‖              // 单位方向向量
          x₁ ← x + λ·u'
          if f(x₁) < f(x):                  // 找到更好的点
              k ← 1
              x ← x₁
          else:
              k ← k + 1
      λ ← λ / 2                             // 步长减半，精细搜索
  return x
  ```

  若连续 $N$ 次找不到更优值，则认为当前最优解在以 $lambda$ 为半径的 $n$ 维球内；此时若 $lambda < epsilon$ 则结束，否则步长减半继续。
]

== 知识延展（教材补充）
<知识延展>

=== 随机化快速排序
<随机化快速排序>

在快速排序的基础上增加#strong[随机选取]主元的步骤。

#algorithm[RANDOMIZEDQUICKSORT 随机化快速排序][
  *输入*：数组 $A[1..n]$
  *输出*：$A$ 中按非降序排列的元素

  ```text
  procedure rquicksort(low, high):
      if low < high then
          v ← random(low, high)
          互换 A[low] 和 A[v]
          SPLIT(A[low..high], w)      // w 是主元新位置
          rquicksort(low, w-1)
          rquicksort(w+1, high)
  ```
]

最坏情况运行时间仍为$Theta(n^2)$，但这与输入形式无关，只取决于随机数生成器的"不幸"。没有一种输入的排列可以引起它的最坏情况。期望运行时间为$Theta(n log n)$，是一个ZPP类算法。

=== 随机化选择算法
<随机选择算法>

#algorithm[RANDOMIZEDSELECT 随机化选择][
  *输入*：数组 $A[1..n]$，整数 $k$（$1 lt.eq k lt.eq n$）
  *输出*：$A$ 中的第 $k$ 小元素

  ```text
  procedure rselect(A, low, high, k):
      v ← random(low, high)
      x ← A[v]
      将 A[low..high] 分成三个数组:
          A₁ = {a | a < x}
          A₂ = {a | a = x}
          A₃ = {a | a > x}
      case:
          |A₁| ≥ k:  return rselect(A₁, 1, |A₁|, k)
          |A₁|+|A₂| ≥ k:  return x
          else:  return rselect(A₃, 1, |A₃|, k - |A₁| - |A₂|)
  ```
]

#strong[期望时间分析]：设$C(n)$为$n$个元素上的期望比较次数。通过归纳法证明$C(n) < 4n$，故期望时间为$Theta(n)$。

=== 多选问题
<多选问题>

设有$n$个元素的数组$A$，$K[1 dots.c r]$（$1 lt.eq r lt.eq n$）是由1到$n$间$r$个正数构成的有序数组。#strong[多选问题]就是对于所有$i$，选择$A$中的第$K[i]$小元素。若$r=1$即选择问题，$r=n$即排序问题。

方法：随机挑选一个元素$a$，将数组$A$关于$a$分割。若两部分均含靶标则递归求解两部分，否则丢弃不含靶标的部分。

该算法以概率$1 - O(1/n)$的时间复杂度为$O(n log r)$。

=== 随机取样
<随机取样>

#algorithm[RANDOMSAMPLING 随机取样][
  *输入*：正整数 $m, n$（$m < n$）
  *输出*：从 ${1,...,n}$ 中随机选取的 $m$ 个不同整数

  ```text
  初始化布尔数组 S[1..n] 全为 false
  k ← 0
  while k < m:
      r ← random(1, n)
      if not S[r] then
          k ← k + 1
          A[k] ← r
          S[r] ← true
  ```

  若 $m > n/2$，反面考虑：随机选 $n-m$ 个整数丢弃，其余保留。
]

#strong[期望时间]：第$k+1$次成功选到新元素的概率$p_k = (n-k)/n$。由几何分布可知期望尝试次数$E_k = n/(n-k)$。总期望时间：
$
  E[T] = sum_(k=0)^(m-1) frac(n, n-k) = n (H_n - H_(n-m))
$
其中$H_n$为调和数。当$m = Theta(n)$时$E[T] = Theta(n)$。

=== 二元布尔可满足问题（2-SAT）
<随机游走解决k-SAT>

==== 随机游走算法求解2-SAT
<2SAT-随机游走>

#problem[2-SAT问题][
  给定一个合取范式（CNF）公式，每个子句恰好包含两个文字（literal），是否存在一组变量赋值使公式成立？\
  2-SAT 可在多项式时间内求解，此处采用随机游走算法。
]

#algorithm[2-SAT 随机游走算法][
  *输入*：$m$ 个子句，$n$ 个变元的 2-SAT 实例
  *输出*：若可满足则返回一组赋值，否则输出"不可满足"

  ```text
  随机初始化赋值 σ：对每个变元随机赋 True 或 False
  for i ← 1 to m:
      if σ 满足所有子句 then return σ
      任选一个不满足的子句
      随机翻转该子句中的一个文字
  return "不可满足"               // m 次内未找到
  ```
]

若输入公式是不可满足的，则算法正确宣布不可满足；若输入公式是可满足的，则算法以$1 - 1/2^m$概率找到可满足赋值。

==== 马尔可夫链分析
<2SAT-马氏链>

定义汉明距离$d(sigma, sigma^*)$为当前赋值与最优赋值之间取值不同的变量个数。对每个不满足子句，至少以$1/2$概率减少汉明距离（因子句最多含2个文字）。

定义马尔可夫链${ Y_0, Y_1, Y_2, dots.c }$：
$
  P(Y_(t+1) = j+1 | Y_t = j) = P(Y_(t+1) = j-1 | Y_t = j) = 1/2
$
$Y_t$比$X_t$花费更长的期望时间到达状态$n$。设$h_j$为从$j$到达$n$的期望时间，则：
$
  h_n = 0, quad h_0 = h_1 + 1, quad h_j = (h_(j+1) + h_(j-1))/2 + 1
$
由归纳法可得$h_j lt.eq n^2 - j^2 lt.eq n^2$。

由马尔可夫不等式（$P(X gt.eq epsilon) lt.eq E[X]/epsilon$）：
$
  P("从" X_0 " 到达 " n " 的时间 " gt.eq 2n^2) lt.eq frac(n^2, 2n^2) = 1/2
$

经过$2n^2 m$步迭代后仍未到达$sigma^*$的概率：
$
  P("失败") lt.eq (1 - frac(1, 2n))^(2n^2 m) approx e^(- n m) lt.eq 1/2^m
$

==== 马尔可夫不等式
<马尔可夫不等式>

#theorem[马尔可夫不等式][
  设 $X$ 为仅取非负的随机变量，数学期望 $E[X] = mu$。则对任意 $epsilon > 0$：
  $
    P(X gt.eq epsilon) lt.eq mu / epsilon
  $
  证明：定义指示变量 $Y = epsilon dot.c bold(1)_{ { X gt.eq epsilon } }$，则 $Y lt.eq X$，故 $E[Y] = epsilon P(X gt.eq epsilon) lt.eq E[X]$。
]

==== 马尔可夫链基础
<马尔可夫链>

#definition[马尔可夫链][
  *马尔可夫特性（无后效性）*：随机过程在给定 $t$ 时刻的状态后，后续状态及其概率与 $t$ 之前的状态无关。当前状态包含了所有历史信息。

  离散随机序列 ${ X_0, X_1, dots.c }$ 若满足
  $
    P(X_(t+1) = x_(t+1) | X_t = x_t, dots.c, X_0 = x_0) = P(X_(t+1) = x_(t+1) | X_t = x_t)
  $
  则称为*有限马尔可夫链*。
]

一步转移矩阵$P = [p_(i,j)]$，其中$p_(i,j) = P(X_(t+1) = j | X_t = i)$。每行元素之和为1。

$m$步转移矩阵满足$P^((m)) = P^m$，状态分布$bold(p)(t+m) = bold(p)(t) P^m$。

== 本章作业
<本章作业>

=== 优惠券收集问题
<优惠劵收集>

#problem[优惠券收集问题][
  有 $n$ 种优惠券，每种数量不限。每次实验随机抽取一张，抽到每种的概率均等。求收集全部 $n$ 种至少一张所需的期望次数。
]

设$X_i$为已收集$i-1$种后首次抽到第$i$种新券所需的次数。已收集$k$种时抽到新券的概率$p_k = (n-k)/n$，$X_(k+1)$服从几何分布，期望$E[X_(k+1)] = 1/p_k = n/(n-k)$。

总次数$T = sum_(i=1)^n X_i$，期望：
$
  E[T] = sum_(k=0)^(n-1) frac(n, n-k) = n sum_(k=1)^n frac(1, k) = n H_n
$
当$n$较大时$H_n approx ln n + gamma$（$gamma approx 0.577$），故$E[T] approx n ln n$。

=== 用公平硬币生成随机排列
<用公平硬币随机序列生成>

#problem[公平硬币生成随机排列][
  给定一枚公平硬币，设计算法生成 $1, 2, ..., n$ 的随机排列。
]

#algorithm[Fisher-Yates 公平硬币版][
  *输入*：正整数 $n$
  *输出*：随机排列 $A[1..n]$

  ```text
  初始化数组 A: A[i] ← i (对 i = 1 到 n)
  for i ← 1 to n:
      用硬币生成一个 j (1 ≤ j ≤ i)
      若 j > i 则重试（拒绝抽样）
      swap(A[i], A[j])
  ```

  每次抽样需 $ceil(log_2 i)$ 次硬币投掷。
]

最优情况时间复杂度$C_("opt")(n) = O(n log n)$。考虑拒绝概率时，因拒绝而产生的额外代价$C_("penalty")(n) = sum_(i=2)^n w_i lt.eq 3n = O(n)$，因此最坏时间复杂度$C_("wor")(n) = O(n log n)$。

=== 矩阵互逆验证
<矩阵互逆>

#problem[矩阵互逆验证][
  给定两个 $n times n$ 方阵 $A$ 和 $B$，判定是否互逆（即 $A B = I$）。基于Monte Carlo方法，通过随机采样验证：

  - 对角线元素应为 $1$（允许误差 $epsilon$）
  - 非对角线元素应为 $0$（允许误差 $epsilon$）

  #strong[时间复杂度]：$O(T dot.c n)$，每次采样需 $O(n)$ 时间计算矩阵元素，共 $T$ 次采样
  #strong[空间复杂度]：$O(1)$（仅需存储临时变量）
]
  #algorithm[蒙特卡罗矩阵互逆验证][
    *输入*：方阵 $A$、$B$（$n times n$）
    *输出*：$A B = I$ 是否成立

    ```text
    重复 k 次（如 k = 30）:
        随机生成向量 r ∈ {0,1}^n
        计算 y ← A(Br)        // 先 B 乘 r，再 A 乘结果
        计算 z ← r            // 因为目标 C = I，I·r = r
        if y ≠ z then
            return false      // 确定 AB ≠ I
    return true               // 可能 AB = I（错误概率 ≤ 2^{-k}）
    ```

    单次测试时间复杂度 $O(n^2)$（矩阵乘向量），总时间 $O(k n^2)$。
    若 $A B 
eq.not I$，单次测试检出概率至少 $1/2$（由 Schwartz-Zippel 引理保证）。
    重复 $k$ 次后错误概率 $lt.eq 2^(-k)$。
  ]