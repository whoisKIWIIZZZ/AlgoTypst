#import "@local/ysz_tools:0.1.0": *
#show: conf.with(
  author: "kiwiizzz",
  title: "AlgoAnalysis",
)
#show ",":"，"
#show "。":","
#import "@preview/cuti:0.4.0":show-cn-fakebold
#show:show-cn-fakebold
= chapter1: 导论
<chapter1-导论>
#block[
  Stirling 公式：
  $ n ! tilde.op sqrt(2 pi n) (n / e)^n ( 1 + Theta ( 1 / n ) ) $

]
啊啊啊寶寶妳是一條區
*是啊,吃什么 是啊,吃什麼*
再san
== 基本概念
<基本概念>
算法是在有限的步骤内求解某一问题，所使用的一组定义明确的规则。也就是在通过一组有限定义的指令来完成一些任务，给定一个初始状态，并相应的获取最终结果。

算法应该具有以下特性：
- 可行性；
- 确定性（每一步都被精确定义，不存在模糊操作）；
- 有限性（程序可以没有这个特性，操作系统就是一个不关机就无限期执行的程序）；
- 输入、输出。

算法是解决问题的抽象步骤，程序是算法的具体实现，算法通过编程语言转为程序，程序在计算机上运行。

算法分析有事前分析与事后测试两种基本方法。

#block[
  对于任何一个计算步骤，如果它的一次执行代价总是以一个时间常数为上界，与输入数据或者使用何种算法无关，则称该计算步骤为"元运算"或"元操作"。

]
#block[
  算法中某个语句或运算的执行次数称为其频度。

]
#block[
  如果算法中的一个元运算具有最高频度，所有其他元运算频度均在它的频度的常数倍内，则称这个元运算为基本运算。

]
== 复杂度
<复杂度>
=== $O$记号：渐进上界记号
<o记号渐进上界记号>
设$f ( n )$和$g ( n ):NN^+ --> RR^+$，如果存在正常数$c$和自然数$n_0$，使得
$ forall n gt.eq n_0 \, f ( n ) lt.eq c dot.op g ( n ) $
则称$f ( n )$是$O ( g ( n ) )$的，记为$f ( n ) = O ( g ( n ) )$#footnote[这种\"=\"的记号的本意其实是$f ( n ) in O ( g ( n ) )$，而对于出现在等式或不等式中的渐进记号表示的也是，其中的某一函数]。

也可以这样理解：
$lim_(n arrow.r oo) frac(f ( n ), g ( n )) eq.not oo ==>  f(n)=O(g(n))$

// 当$lim_(n arrow.r oo) frac(f ( n ), g ( n ))$存在且不为无穷，那么就有$f ( n ) = O ( g ( n ) )$，(但是ppt上似乎还要求极限不为无穷，私以为这里把极限为无穷也算作了极限存在的一种)

=== $Omega$记号：渐进下界记号
<omega记号渐进下界记号>
设$f ( n )$和$g ( n ):NN^+ --> RR^+$，如果存在正常数$c$和自然数$n_0$，使得
$ forall n gt.eq n_0 \, f ( n ) gt.eq c dot.op g ( n ) $
则称$f ( n )$是$Omega ( g ( n ) )$的，记为$f ( n ) = Omega ( g ( n ) )$。

也可以这样理解：$lim_(n arrow.r oo) frac(f ( n ), g ( n )) eq.not 0 ==> f ( n ) = Omega ( g ( n ) )$

=== $Theta$-记号：紧渐进界记号
<theta-记号紧渐进界记号>
如果存在2个正常数$c_1 \, c_2$和自然数$n_0$，使得
$ forall n gt.eq n_0 \, c_1 dot.op g ( n ) lt.eq f ( n ) lt.eq c_2 dot.op g ( n ) $
则称$f ( n )$是$Theta ( g ( n ) )$，记为$f ( n ) = Theta ( g ( n ) )$。

也就是说，$lim_(n arrow.r oo) frac(f ( n ), g ( n )) = c > 0 ==> f ( n ) = Theta ( g ( n ) )$

可以推断，$f ( n ) = Theta ( g ( n ) ) arrow.l.r.double f ( n ) = O ( g ( n ) ) and f ( n ) = Omega ( g ( n ) )$,
此时称$f ( n )$与$g ( n )$同阶，

=== $o$-记号
<o-记号>
对于任意给定的$c > 0$，都存在正整数$n_0$，使得当$n gt.eq n_0$时有
$ f ( n ) < c dot.op g ( n ) $
则称函数$f ( n )$是$o ( g ( n ) )$的，记为$f ( n ) = o ( g ( n ) )$。

也就是说：$lim_(n arrow.r oo) frac(f ( n ), g ( n )) = 0 ==> f ( n ) = o ( g ( n ) )$.

因此可以有：
$ f ( n ) = o ( g ( n ) ) <==> f ( n ) = O ( g ( n ) ) and g ( n ) eq.not O ( f ( n ) ) $
当$n$充分大时，$f ( n )$的阶比$g ( n )$低。

=== $omega$-记号：非紧下界记号
<omega-记号非紧下界记号>
对于任意给定的$c > 0$，都存在正整数$n_0$，使得当$n gt.eq n_0$时有$f ( n ) > c dot.op g ( n )$，则称函数$f ( n )$时$omega ( g ( n ) )$的，记为$f ( n ) = omega ( g ( n ) )$。

等价于：$lim_(n arrow.r oo) frac(f ( n ), g ( n )) = oo ==> f ( n ) = omega ( g ( n ) )$.

=== 渐进记号的性质
<渐进记号的性质>
+ 传递性：所有符号

+ 自反性：$Theta \, O \, Omega$

+ 对称性：$Theta$

+ 互对称性：
  $
    f ( n ) = O ( g ( n ) ) & arrow.l.r.double g ( n ) = Omega ( f ( n ) ) \
    f ( n ) = o ( g ( n ) ) & arrow.l.r.double g ( n ) = omega ( f ( n ) )
  $

+ 算数计算
  - $O ( f ( n ) ) + O ( g ( n ) ) = O ( max { f ( n ) \, g ( n ) } )$

  - $O ( f ( n ) ) + O ( g ( n ) ) = O ( f ( n ) + g ( n ) )$

  - $O ( f ( n ) ) * O ( g ( n ) ) = O ( f ( n ) * g ( n ) )$

  - $O ( c dot.op f ( n ) ) = O ( f ( n ) )$

  - $g ( n ) = O ( f ( n ) ) arrow.r.double O ( f ( n ) ) + O ( g ( n ) ) = O ( f ( n ) )$

算法的空间复杂度是对一个算法在运行过程中#strong[临时使用存储空间的渐进度量]。

== 平摊分析
<平摊分析>
=== 聚集分析
<聚集分析>
将所有的操作加起来，然后除以操作数，得到的结果就是平摊代价。

=== 记账法
<记账法>
对不同操作赋予不同的费用，这个均摊成本$hat(c)_(o p)$可能与实际成本$c_(o p)$不同，但必须要满足的是，对于任意的合法的$n$个操作序列，必须有$T ( n ) = sum_(i = 1)^n c_i lt.eq sum_(i = 1)^n hat(c)_i$.

这种方法更常见于对一个已知的均摊代价进行巧妙的证明。例如：对于二进制计数器算法，因为每一个操作1翻转为0中的1，都一定来自于一个操作：0翻转为1，而最终结果一定会剩余一定量的1，所以操作：0翻1的数量大于1翻0的数量。

#figure(
  align(center)[#table(
    columns: 3,
    align: (left, center, center),
    table.header(
      [#strong[OP]],
      [#strong[Real Cost]
        $bold(C_(O P))$],
      [#strong[Amortized Cost] $bold(hat(C)_(O P))$],
    ),
    table.hline(),
    [flip ($0 arrow.r 1$)], [1], [2],
    [flip ($1 arrow.r 0$)], [1], [0],
  )],
  caption: [Binary Counter Flip Operations: Real Cost vs. Amortized
    Cost],
  kind: table,
)

$
  T ( n ) & = sum_(i = 1)^n C_i \
            & = \# upright(f l i p) ( 0 arrow.r 1 ) + \# upright(f l i p) ( 1 arrow.r 0 ) \
            & lt.eq 2 dot.op \# upright(f l i p) ( 0 arrow.r 1 ) \
            & lt.eq 2 n
$

=== 势能法
<势能法>
势能函数充当能量存储罐的作用，当操作简单时就会势能增加（相当于存钱）；当操作复杂时就会势能减少（相当于取钱）；那么每次操作的平摊代价=实际操作成本+存储罐的变化量。即：
$ a_i = c_i + Phi ( D_i ) - Phi ( D_(i - 1) ) $
那么对于$n$个操作的总平摊代价为：
$ sum a_i = sum c_i + Phi ( D_n ) - Phi ( D_0 ) $

如果势函数使得对所有的$n$，都有$Phi ( D_n ) gt.eq Phi ( D_0 )$，则总平摊代价就是总实际代价的一个上界，为了方便起见有时会定义$Phi ( D_0 ) = 0$.

== 递推关系
<递推关系>
（高中部分内容不再展开）

=== 主定理
<主定理>
#block[
  设$a gt.eq 1 \, b gt.eq 1$为常数，$f ( n )$为函数,
  $T ( n )$为非负正数，且 $ T ( n ) = a T ( n / b ) + f ( n ) $
  那么就有

  - $f ( n ) = O ( n^(log_b a - epsilon) ) \, epsilon > 0$
    那么$T ( n ) = Theta ( n^(log_b a) )$

  - $f ( n ) = Theta ( n^(log_b a) )$,
    那么$T ( n ) = Theta ( n^(log_b a) log n )$

  - $f ( n ) = Omega ( n^(log_b a + epsilon) ) \, epsilon > 0$，
    且对某个常数$c < 1$和所有充分大的$n$有$a dot.op f ( n / b ) lt.eq c dot.op f ( n )$，
    那么$T ( n ) = Theta ( f ( n ) )$

]
#block[
  #emph[Proof.] 设$n = b^k$, 则有
  $
    T ( n ) & = a^k T ( 1 ) + sum_(j = 0)^(k - 1) a^j f ( n / b^j ) \
              & = c_1 n^(log_b a) + sum_(j = 0)^(k - 1) a^j f ( n / b^j ) \, T ( 1 ) = c_1 \
  $

  - #strong[情况1]
    $
      T ( n ) & = c_1 n^(log_b a) + sum_(j = 0)^(k - 1) a^j f (n / b^j)\
      & = c_1 n^(log_b a) + O (sum_(j = 0)^(log_b n - 1) a^j (n / b^j)^(log_b a - epsilon))\
      & = c_1 n^(log_b a) + O (n^(log_b a - epsilon) sum_(j = 0)^(log_b n - 1) frac(a^j, ( b^(log_b a - epsilon) )^j))\
      & = c_1 n^(log_b a) + O (n^(log_b a - epsilon) sum_(j = 0)^(log_b n - 1) ( b^epsilon )^j)\
      & = c_1 n^(log_b a) + O (n^(log_b a - epsilon) dot.op frac(b^(epsilon log_b n) - 1, b^epsilon - 1))\
      & = c_1 n^(log_b a) + O (n^(log_b a - epsilon) dot.op n^epsilon)\
      & = Theta ( n^(log_b a) )
    $

  - #strong[情况2]

    $
      T ( n ) & = c_1 n^(log_b a) + sum_(j = 0)^(k - 1) a^j f (n / b^j) \
                & = c_1 n^(log_b a) + Theta (sum_(j = 0)^(log_b n - 1) a^j (n / b^j)^(log_b a)) \
                & = c_1 n^(log_b a) + Theta (n^(log_b a) sum_(j = 0)^(log_b n - 1) a^j / a^j) \
                & = c_1 n^(log_b a) + Theta (n^(log_b a) log n) \
                & = Theta (n^(log_b a) log n)
    $

  - #strong[情况3]
    $
      T ( n ) & = c_1 n^(log_b a) + sum_(j = 0)^(k - 1) a^j f (n / b^j) \
                & lt.eq c_1 n^(log_b a) + sum_(j = 0)^(log_b n - 1) c^j f ( n ) quad (a f (n / b) lt.eq c f ( n )) \
                & = c_1 n^(log_b a) + f ( n ) frac(c^(log_b n) - 1, c - 1) \
                & = c_1 n^(log_b a) + Theta ( f ( n ) ) quad ( c < 1 ) \
                & = Theta ( f ( n ) ) quad (f ( n ) = Omega (n^(log_b a + epsilon)))
    $

  ~◻

]
对于$T ( n ) = 2 T ( n / 2 ) + n log n$,
就是不能使用主定理的，因为不存在$epsilon > 0$使得$n log n = Omega ( n^(1 + epsilon) )$.

这个可以用递归树进行求解，恰好这个拆解得到的是平衡树，只需要对$f ( n )$项求和即可。
$
  T ( n ) & = sum_(i = 0)^(log n) n ( log n - i ) \
            & = n log^2 n = O ( n log^2 n )
$

=== Akra-Bazzi定理
<akra-bazzi定理>
Akra-Bazzi定理是分析分治算法时间复杂度的强大工具，它推广了经典的主定理(Master
Theorem)，适用于更广泛的递归关系。

对于递归关系式：
$ T ( n ) = sum_(i = 1)^k a_i T ( b_i n + h_i ( n ) ) + f ( n ) $
其中：

- $a_i > 0$ 且 $0 < b_i < 1$（对所有$i = 1 \, dots.h \, k$）

- $\| h_i ( n ) \| = O (frac(n, log^2 n))$（扰动项）

- $f ( n )$ 满足某些正则条件

定义$p$为方程的解： $ sum_(i = 1)^k a_i b_i^p = 1 $ 则时间复杂度为：
$ T ( n ) = Theta (n^p (1 + integral_1^n frac(f ( u ), u^(p + 1)) d u)) $

#figure(
  align(center)[#table(
    columns: 2,
    align: (left, left),
    table.header([#strong[特征]], [#strong[Akra-Bazzi定理]]),
    table.hline(),
    [适用范围], [非均匀划分的递归式],
    [扰动项], [允许$h_i ( n )$存在],
    [驱动函数], [$f ( n )$形式更灵活],
    [解的形式], [积分表达式],
  )],
  caption: [主定理与Akra-Bazzi定理对比],
  kind: table,
)

=== 应用示例
<应用示例>
分析递归式
$T ( n ) = T ( floor.l n \/ 2 floor.r ) + T ( ceil.l n \/ 2 ceil.r ) + n$：

+ 确定参数：$a_1 = a_2 = 1$, $b_1 = b_2 = 1 \/ 2$

+ 解方程：$2 dot.op ( 1 \/ 2 )^p = 1 arrow.r.double p = 1$

+ 计算积分：$integral_1^n u / u^2 d u = ln n$

+ 最终解：$T ( n ) = Theta ( n ( 1 + ln n ) ) = Theta ( n log n )$

当递归式满足主定理条件时，Akra-Bazzi定理给出的结果与主定理一致，但前者适用性更广。

不过其实用数学归纳法会更舒适一些。例如估计以下复杂度：
$ T ( n ) = T ( n / 5 ) + T ( frac(7 n, 10) ) + Theta ( n ) $

假设对任意的$m < n$，都有$T ( m ) < c m$恒成立，其中$c$为常数，下面证明$T ( n ) < c n$即可证明出$T ( n ) = Theta ( n )$

$
  T ( n ) & = T ( n / 5 ) + T ( frac(7 n, 10) ) + Theta ( n ) \
            & < T ( n / 5 ) + T ( frac(7 n, 10) ) + d n \
            & < c n / 5 + c frac(7 n, 10) + d n \
            & = ( c / 5 + frac(7 c, 10) + d ) n < c n \
$

因而只需取$c > 10 d$即可。

=== 递推关系求解练习
<递推关系求解练习>
+ $T ( n ) = T ( n / 2 ) + T ( n / 4 ) + c n$
  $
    & upright("令") n = 2^k \, T ( 2^k ) = T ( 2^(k - 1) ) + T ( 2^(k - 2) ) + c dot.op 2^k\
    & upright("构建递归树知，若设") T ( 2^(k - i) ) upright("的结点数量是") f \[ i \] upright("，则有") f \[ i \] = f \[ i - 1 \] + f \[ i - 2 \]\
    & upright("且") f \[ 0 \] = f \[ 1 \] = 1 \, upright("因此叶子结点数量为") f \[ k \] = 1 / sqrt(5) [(frac(1 + sqrt(5), 2))^(k + 1) - (frac(1 - sqrt(5), 2))^(k + 1)]\
    & 1 / sqrt(5) [(frac(1 + sqrt(5), 2))^(k + 1) - lr(|(frac(1 - sqrt(5), 2))^(k + 1)|)] lt.eq f \[ k \] lt.eq 1 / sqrt(5) (frac(1 + sqrt(5), 2))^(k + 1)\
    & therefore f \[ k \] = O ( a^k ) = O ( n^(log_2 a) ) \, upright("其中") a = frac(1 + sqrt(5), 2)\
    & upright("而对于计算耗时为：") c n dot.op sum_(i = 1)^n (3 / 4)^(i - 1) = O ( n ) > O ( n^(log_2 a) )\
    & therefore T ( n ) = O ( n )
  $

+ $T ( n ) = T ( n - 1 ) + log n$
  $
    & upright("原式") = T ( 1 ) + sum_(i = 2)^n log i\
    upright("下证") & : sum_(i = 2)^n log i upright(" 与 ") n log n upright(" 同阶")\
    upright("由Stolz定理知，") & lim_(n arrow.r oo) frac(sum_(i = 2)^n log i, n log n) = lim_(n arrow.r oo) frac(log n, n log n - ( n - 1 ) log ( n - 1 )) = lim_(n arrow.r oo) frac(log n, log ( n - 1 )) = 1\
    & therefore T ( n ) = Theta ( n log n )
  $

== 本章作业
<本章作业>
=== 势函数规范化构造及其平摊代价不变性证明
<势函数规范化构造及其平摊代价不变性证明>
假定有势函数 $Phi$，对所有 $i gt.eq 1$ 满足
$Phi ( D_i ) gt.eq Phi ( D_0 )$，但
$Phi ( D_0 ) eq.not 0$。证明：存在势函数 $Phi'$，使得
$Phi' ( D_0 ) = 0$，对于所有 $i gt.eq 1$，满足
$Phi' ( D_i ) gt.eq 0$，且使用 $Phi'$ 的平摊代价与使用 $Phi$
的平摊代价相同。

#block[
  #emph[Proof.] 设新的势函数为：
  $ Phi' ( D_i ) = Phi ( D_i ) - Phi ( D_0 ) quad ( i = 0 \, 1 \, 2 \, dots.h ) $

  + #strong[零势初始化]：
    $ Phi' ( D_0 ) = Phi ( D_0 ) - Phi ( D_0 ) = 0 $

  + #strong[非负性保持]（$forall i gt.eq 1$）：
    $
      Phi' ( D_i ) = Phi ( D_i ) - Phi ( D_0 ) gt.eq 0 quad upright("（由已知条件 ") Phi ( D_i ) gt.eq Phi ( D_0 ) upright("）")
    $

  + #strong[平摊代价不变性]： 对于任意操作，设实际代价为 $c_i$，有：
    $
      hat(c)'_i & = c_i + Phi' ( D_i ) - Phi' ( D_(i - 1) ) \
                & = c_i + ( Phi ( D_i ) - Phi ( D_0 ) ) - ( Phi ( D_(i - 1) ) - Phi ( D_0 ) ) \
                & = c_i + Phi ( D_i ) - Phi ( D_(i - 1) ) \
                & = hat(c)_i
    $

  ~◻

]
=== 聚集法计算平摊代价
<聚集法计算平摊代价>
假定对一个数据结构执行一个由$n$个操作组成的操作序列，当$i$严格为2的幂时，第$i$个操作的代价为$i$，否则代价为1。请使用聚集法确定每个操作的平摊代价。

考虑$n$个操作序列的总代价： $ T ( n ) = sum_(k = 0\
2^k lt.eq n)^(floor.l log_2 n floor.r) 2^k + #scale(x: 180%, y: 180%)[(] n - floor.l log_2 n floor.r - 1 #scale(x: 180%, y: 180%)[)] $
展开后可得：
$ T ( n ) = ( 2^(floor.l log_2 n floor.r + 1) - 1 ) + ( n - floor.l log_2 n floor.r - 1 ) lt.eq 3 n $
因此平摊代价为： $ frac(T ( n ), n) lt.eq 3 = O ( 1 ) $

=== 主定理运用
<主定理运用>
设递推方程 $T ( n ) = 7 T ( n / 2 ) + n^2$
给出了算法$A$在最坏情况下的时间复杂度函数，算法$B$在最坏情况下的时间复杂度函数
$W ( n )$ 满足递推方程
$W ( n ) = a W ( n / 4 ) + n^2$。试确定最大的正整数 $a$，使得
$W ( n )$ 的阶低于 $T ( n )$ 的阶。

$ & because T ( n ) = 7 T (n / 2) + n^2\
& therefore a = 7 \, med b = 2 \, med f ( n ) = n^2\
& therefore n^(log_b a) = n^(log_2 7) \, med f ( n ) = n^2 = O (n^(log_2 7 - epsilon)) \, med epsilon > 0\
& therefore T ( n ) = Theta (n^(log_2 7))\
& upright("又") because W ( n ) = a W (n / 4) + n^2\
& therefore n^(log_b a) = n^(log_4 a) = n^(1 / 2 log_2 a) \, med f' ( n ) = n^2\
& upright("if ") a = 16 \, med f' ( n ) = Theta (n^(log_b a)) \, med W ( n ) = Theta (n^2 log n) < Theta (n^(log_2 7)) \, med upright("满足题意")\
& upright("if ") a > 16 \, med f' ( n ) = O (n^(log_b a - epsilon)) \, med epsilon > 0 \, med W ( n ) = Theta (n^(log_b a)) < Theta (n^(log_2 7))\
& therefore sqrt(a) < 7 \, med a < 49\
& therefore a_max = 48 > 16\
& therefore a_max = 48 $ 注意$a = 16$的讨论是必要的。
