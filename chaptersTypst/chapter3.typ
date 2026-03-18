= chapter3 分治
<chapter3-分治>
// 哦哦哦哦哦哦心理委员我好得劲哦哦哦哦哦哦心理委员我好得劲哦哦哦哦哦哦心理委员我好得劲哦哦哦哦哦哦心理委员我好得劲哦哦哦哦哦哦心理委员我好得劲哦哦哦哦哦哦心理委员我好得劲哦哦哦哦哦哦心理委员我好得劲哦哦哦哦哦哦心理委员我好得劲哦哦哦哦哦哦心理委员我好得劲哦哦哦哦哦哦心理委员我好得劲哦哦哦哦哦哦心理委员我好得劲哦哦哦哦哦哦心理委员我好得劲哦哦哦哦哦哦心理委员我好得劲哦哦哦哦哦哦心理委员我好得劲哦哦哦哦哦哦心理委员我好得劲哦哦哦哦哦哦心理委员我好得劲哦哦哦哦哦哦心理委员我好得劲哦哦哦哦哦哦心理委员我好得劲哦哦哦哦哦哦心理委员我好得劲哦哦哦哦哦哦心理委员我好得劲哦哦哦哦哦哦心理委员我好得劲哦哦哦哦哦哦心理委员我好得劲哦哦哦哦哦哦心理委员我好得劲哦哦哦哦哦哦心理委员我好得劲
把规模大的问题分解成小规模问题，要求子问题#strong[互相独立]且#strong[与原问题形式相同]，递归解决这些子问题，再把他们的解合并到原问题中，这样的策略称为#strong[分治法]。

归纳法是#strong[尾递归]思想，通过扩展子问题解的方式得到原问题的解；而分治法是划分的思想，再合并得到原问题的解。

== 分治思想
<分治思想>
分治范式通常由以下的步骤组成：

- #strong[划分步骤]。在算法的这个步骤中，输入被分成$p gt.eq 1$个部分，每个子实例的规模严格小于$n$，$n$是原始实例的规模。尽管比$2$大的其他小的常数很普遍，但$p$的最常用的值是$2$。$p$也可以具有与$log n$，$n^epsilon$一样高的数量级($0 < epsilon < 1$)。

- #strong[治理步骤]。如果问题的规模大于某个预定的阈值$n_0$，这个步骤由执行$p$个递归调用组成，阈值是由算法的数学分析导出的。

- #strong[组合步骤]。这个步骤是组合$p$个递归调用的解来得到期望的输出值。

#strong[分治法所能解决的问题一般具有以下几个特征：]

- 该问题的规模缩小到一定的程度就可以容易地解决；

- 该问题可以分解为若干个规模较小的相同问题，即具有最优子结构性质（问题的最优解所包含的子问题的解也是最优的）；

- 利用该问题分解出的子问题的解可以合并为该问题的解；

- 该问题所分解出的各个子问题是相互独立的，即子问题之间不包含公共的子问题。

== 分治算法举例
<分治算法举例>
=== 归并排序
<归并排序>
#block[
]
如果$n$是2的幂时，两个算法的执行比较次数相同。合并两个排好序的子数组，所需要的元素比较次数在$n / 2$和$n - 1$之间，所以最小比较次数是：
$ c \( n \) = 2 c \( n / 2 \) + n / 2 \， n gt.eq 2 $

最多比较次数： $ c \( n \) = 2 c \( n / 2 \) + n - 1 \, n gt.eq 2 $

由主定理知，$c \( n \) = Theta \( n log n \)$如果$n$是任意的正整数，则算法执行元素比较次数是：
$ c \( n \) = c \( floor.l n \/ 2 floor.r \) + c \( ceil.l n \/ 2 ceil.r \) + b n \, n gt.eq 2 $
时间复杂度是$Theta \( n log n \)$，空间复杂度是$Theta \( n \)$（开出一个临时数组就够用）。

=== 选择问题：寻找第k小元素
<选择问题寻找第k小元素>
#block[
分组：将 $n$ 个元素每 5 个一组，分成 $\lfloor n/5 \rfloor$ 组。

找中位数：对每组进行内部排序（因为每组只有 5 个元素，复杂度是 $O(1)$），找出每组的中位数。

递归找“中位数的中位数”：将上一步找到的所有中位数组成一个新集合 $M$，递归调用算法，找到 $M$ 中的中位数，记为 $m m$。

划分（Partition）：以 $m m$ 为基准，将原数组分为三部分：
- $A_1$: 小于 $m m$ 的元素。
- $A_2$: 等于 $m m$ 的元素。
- $A_3$: 大于 $m m$ 的元素。

]

#image("/assets/image.png")

设$A'_1$表示小于等于$m m$的元素集，$A'_3$表示大于等于$m m$的元素集。

由于$A'_1$至少与W区域同样大，然后用总的元素个数减去$A'_1$就是$A_3$：
$
  & \| A'_1 \| gt.eq 3 ceil.l frac(floor.l n \/ 5 floor.r, 2) ceil.r gt.eq 3 / 2 floor.l n / 5 floor.r \
  & \| A_3 \| lt.eq n - 3 / 2 floor.l n / 5 floor.r lt.eq n - 3 / 2 \( frac(n - 4, 5) \) = n - 0.3 n + 1.2 = 0.7 n + 1.2 \
$

令$0.7 n + 1.2 lt.eq floor.l 0.75 n floor.r$，解得$n gt.eq 44$\(这里的$3 / 4$选的很好，不到$4 / 5$，又超过$2 / 3$)

所以有： $
T(n) <= cases(
  c & "if " n < 44,
  T(floor(n / 5)) + T(floor((3n) / 4)) + c n & "if " n >= 44
)
$ 因而$T \( n \) lt.eq frac(c n, 1 - 1 / 5 - 3 / 4) = 20 c n$。

对于代码实现，我们可以对快排进行改造：

```cpp
void qsort(int l, int r){
    // if(l >= r) return;
    // 这个必须要注释掉，否则就可能不输出了
    int i = l, j = r, x = a[(l + r) >> 1];
    while(i <= j){
        while(a[i] < x) i++;
        while(a[j] > x) j--;
        if(i <= j){
            swap(a[i], a[j]);
            i++; j--;
        }
    }
    if(k <= j) qsort(l, j);
    else if(k >= i) qsort(i, r);
    else{
        printf("%d\n", a[j + 1]);
        exit(0);
    }
}
```

快排是需要$O \( n \)$的空间来存储递归中的左右边界的。运行时间最坏情况下为$Theta \( n^2 \)$，整体复杂度为$Theta \( n log n \)$。

=== 最值选择算法的改进
<最值选择算法的改进>
==== 原始MINMAX算法
<原始minmax算法>
原始算法要求输入规模$n$必须为2的幂次（$n = 2^k$），其伪代码如下：

#block[
]
#strong[时间复杂度分析]：

- 比较次数递推式：
  $ C \( n \) = cases(delim: "{", 1 & n = 2, 2 C \( n \/ 2 \) + 2 & n > 2) $

- 精确解：$C \( n \) = frac(3 n, 2) - 2$

==== 改进后的MINMAX算法
<改进后的minmax算法>
改进算法通过以下修改支持任意正整数$n$：

#block[
]
==== 改进要点分析
<改进要点分析>
- #strong[新增递归基]：处理$n = 1$的情况（第3-4行）

- #strong[非对称划分]：采用$floor.l n \/ 2 floor.r$和$ceil.l n \/ 2 ceil.r$划分

- #strong[通用性]：支持任意正整数输入规模

==== 比较次数分析
<比较次数分析>
改进后的比较次数满足递推关系：
$
  T \( n \) = cases(delim: "{", 0 & n = 1, 1 & n = 2, T \( floor.l n \/ 2 floor.r \) + T \( ceil.l n \/ 2 ceil.r \) + 2 & n > 2)
$

==== 理论结论
<理论结论>
- 改进算法比较次数趋近于$ceil.l frac(3 n, 2) ceil.r - 2$但非严格相等

- 当$n = 2^k$时与原始算法完全一致

- 最坏情况下比较次数上界为$3 ceil.l n \/ 2 ceil.r - 2$

=== 有序矩阵找第k小的数
<有序矩阵找第k小的数>
给定一个$n times n$的矩阵，其中每一行和每一列的元素均按升序排列。需要找到矩阵中第$k$小的元素。

+ #strong[二分查找区间]：初始区间为矩阵的最小值和最大值：
  $ l = upright("matrix") \[ 0 \] \[ 0 \] \, quad r = upright("matrix") \[ n - 1 \] \[ n - 1 \] $

+ #strong[统计小于等于$upright("mid")$的元素个数]：

  - 对于中点$upright("mid")$，统计矩阵中$lt.eq upright("mid")$的元素个数$upright("count")$

  - 利用每行有序的性质，在每行中用二分查找（`upper_bound`）统计

+ #strong[调整区间]：
  $ upright("count") < k arrow.r.double l = upright("mid") + 1 $
  $ upright("count") gt.eq k arrow.r.double r = upright("mid") - 1 $

+ #strong[终止条件]：当$l > r$时，$l$即为第$k$小的元素

- 时间复杂度：$O \( n log n log C \)$

  - 二分查找次数：$O \( log C \)$（$C = upright("max") - upright("min")$）

  - 每次统计$upright("count")$：$O \( n log n \)$

- 空间复杂度：$O \( 1 \)$

#block[
  $n arrow.l upright("len(matrix)")$
  $l arrow.l upright("matrix") \[ 0 \] \[ 0 \]$
  $r arrow.l upright("matrix") \[ n - 1 \] \[ n - 1 \]$

]
=== 多数元素问题
<多数元素问题>
根据多数元素的定义可知多数元素必定在数组中出现次数最多，而若将原数组分成2部分，则在其中一部分出现次数最多的必定是多数元素。

该算法的时间复杂度是$O \( n log n \)$，空间复杂度是$O \( log n \)$.

=== 芯片测试问题
<芯片测试问题>
问题描述：有n片芯片，已知其中好芯片至少比坏芯片多1片，需要通过测试从中找出1片好芯片。如何设计一个算法，使用最少测试次数，从中挑出1片好芯片？

测试方法：将芯片放到测试台上，2片芯片互相测试，并报告结果"好"或"坏"。好芯片报告结果一定是正确的，坏芯片的报告不可靠（可能对也可能不对）。

如果$n$是偶数，那么将$n$片芯片两两一组做淘汰测试，剩下芯片构成子问题，进入下一轮分组淘汰。

淘汰规则：如果报告结果为"好，好"，则任留1片，否则全部抛弃，对于$n = 3$单独测试，对于$n = 2 \, n = 1$的情况，则任取其一就是好芯片。

要证明分治算法的正确性，只需要证明#strong[子问题与愿问题性质相同]且#strong[算法是有退出的出口的]。

如果$n$是奇数，则任选1个芯片，用其他$n - 1$个芯片对他进行测试，若是好芯片，则算法退出，否则丢弃他，转化为是偶数个的情况。

设$W \( n \)$是最坏情况下的测试次数，那么有：
$ W \( n \) = W \( n / 2 \) + O \( n \) $
由主定理知，$W \( n \) = O \( n \)$

=== 循环赛日程表
<循环赛日程表>
设有$n = 2^k$个运动员要进行网球循环赛。现要设计一个满足以下要求的比赛日程表：

+ 每个选手必须与其他n-1个选手各赛一次；

+ 每个选手一天只能赛一次；

+ 循环赛一共进行n-1天。

```
void sol(int x, int y, int size, int st){
    if(size >= 2){
        sol(x, y, size - 1, st);
        sol(x + (1 << (size - 1)), y, size - 1, st + (1 << (size - 1)));
        sol(x, y + (1 << (size - 1)), size - 1, st + (1 << (size - 1)));
        sol(x + (1 << (size - 1)), y + (1 << (size - 1)), size - 1, st);
    }
    else{
        plan[x][y] = plan[x + 1][y + 1] = st;
        plan[x + 1][y] = plan[x][y + 1] = st + 1;
    }
}
```

=== 向量卷积
<向量卷积>
给定向量$a = \( a_0 \, a_1 \, dots.h \, a_n \) \, b = \( b_0 \, b_1 \, dots.h \, b_n \)$，则有二者的卷积为$c = \( c_0 \, c_1 \, dots.h \, c_n \)$，其中
$ c_i = sum_(j = 0)^i a_j b_(i - j) $

而卷积与多项式乘法等价，即令$A \( x \) = a_0 + a_1 x + dots.h + a_(m - 1) x^(m - 1) \, B \( x \) = b_0 + b_1 x + dots.h + b_(n - 1) x^(n - 1)$，则
$C \( x \) = A \( x \) B \( x \) = a_0 b_0 + \( a_0 b_1 + a_1 b_0 \) x + dots.h + a_(m - 1) b_(n - 1) x^(m + n - 2)$

如果采用暴力做法，先逐项相乘，再同类合并，那么复杂度将是$O \( n^2 \)$.

我们设计特定值$x_1 \, x_2 \, dots.h \, x_(2 n)$求出$A \( x_j \)$和$B \( x_j \) \, j = 1 \, 2 \, dots.h \, 2 n$，进一步地计算出$C \( x_j \)$，最后利用多项式插值方法，根据$C \( x \)$在$x = x_1 \, x_2 \, dots.h \, x_(2 n)$的插值点，求出$C \( x \)$.

而基于此，我们最关键的计算提速步骤就在于利用分治算法的思想对$A \( x_i \)$的求值步骤进行加速：
$
  A_(e v e n) \( x \) & = a_0 + a_2 x + a_4 x^2 + dots.h + a_(n - 2) x^(frac(n - 2, 2)) \
    A_(o d d) \( x \) & = a_1 + a_3 x + a_5 x^2 + dots.h + a_(n - 1) x^(frac(n - 2, 2)) \
            A \( x \) & = A_(e v e n) \( x^2 \) + x A_(o d d) \( x^2 \)
$

这里相当于把本来$x$是1的$2 n$次方根，变成了$x^2$是1的$n$次方根，实现了问题的降级，从根本上使得复杂度从$O \( n^2 \)$变成了$O \( n log n \)$.

而在这个过程中，我们利用复数单位根的对称性可以进一步地加速，即：
$
        A \( w_j \) & = A_(e v e n) \( w_j^2 \) + w_j A_(o d d) \( w_j^2 \) \
  A \( w_(j + n) \) & = A_(e v e n) \( w_j^2 \) - w_j A_(o d d) \( w_j^2 \)
$

而如何通过$C \( w_i \)$求出$c_i$，方法如下，但是不要深究。

构造多项式：
$ D \( x \) = C \( w_0 \) + C \( w_1 \) x + dots.h + C \( w_(2 n - 1) \) x^(2 n - 1) $

可以证明（别管怎么证的）： $ D \( w_i \) = 2 n c_(2 n - j) $

至此，时间复杂度被优化到了$O \( n log n \)$

=== 棋盘覆盖
<棋盘覆盖>
其实就是这个题，分治思想：
#link("https://www.luogu.com.cn/problem/P1228")

由此可想到将一个边长为 $2^k$ 的正方形分成四个边长为 $2^(k - 1)$
的正方形，特殊方格必在其中的一个正方形中。然后再中心摆上一个地毯，地毯缺少的一块朝向特殊方格所在正方形，这样相当于每个小正方形中有一个特殊方格。一直分治下去，直到边长为
2 结束。

=== 最大子序列和问题
<最大子序列和问题>
题目：#link("https://www.luogu.com.cn/problem/P1115")

+ 第一个数为一个有效序列

+ 如果一个数加上上一个有效序列得到的结果比这个数大，那么该数也属于这个有效序列。

+ 如果一个数加上上一个有效序列得到的结果比这个数小，那么这个数单独成为一个新的有效序列

+ 在执行上述处理的过程中实时更新当前有效序列的所有元素之和并取最大值。

这样代码就是：

```
for(int i=0;i<n;i++){
    cin>>a;
    f=max(f+a,a);
    ans=max(f,ans);
}
```

而如果用分治算法解决这道题，只需要求出左半部分和右半部分的最大子序列和，最后计算一定要包含中间的最大子序列和，三者取最大值就是答案。

```
int g(int l,int m,int r){//l,右边界、r,左边界、m,中间数
    int max1=a[m],max2=a[m+1];//最大值
    int sum1=0,sum2=0;//和，循环用
    //从m向左延伸
    for(int i=m;i>=l;i--){
        sum1+=a[i];
        max1=max(max1,sum1);
    }
    //从m+1向右延伸
    for(int i=m+1;i<=r;i++){
        sum2+=a[i];
        max2=max(max2,sum2);
    }
    return max1+max2;
}

int he(int l,int r){
    if(l==r){
        return a[l];
    }
    int mid=(l+r)/2;
    return max(he(l,mid),max(he(mid+1,r),g(l,mid,r)));
}
```

== 分治算法的改进
<分治算法的改进>
主要就是两个渠道：减少子问题数量、减少递归内部计算量。

=== 大整数乘法
<大整数乘法>
设$n$是2的幂，$u = w dot.op 2^(n / 2) + x \, v = y dot.op 2^(n / 2) + z$,那么$u v = w y 2^n + \( x y + w z \) 2^(n / 2) + x z$，但是这样时间复杂度是$Theta \( n^2 \)$的。

我们可以考虑$w z + x y = \( w + x \) \( y + z \) - w y - x z$，这样就只需要进行3个$n / 2$的子问题了，复杂度为$Theta \( n^(log 3) \) = O \( n^1.59 \)$

=== 矩阵乘法
<矩阵乘法>
暴力做法是$Theta \( n^3 \)$的，而如果只是粗暴的分区处理，仍然是$Theta \( n^3 \)$的，这里我们介绍STRASSEN算法，增加加减法的次数来减少乘法次数。

+ 与朴素分治算法相同，分解出左上，左下，右上，右下四个子矩阵。

+ 创建10个$n / 2 times n / 2$的矩阵$S_i$，每个$S_i$保存两个子矩阵的和或差。

+ 用子矩阵和$S_i$相乘，递归地计算7个$n / 2 times n / 2$的矩阵$P_i$。

+ 通过$P_i$的不同组合进行加减，得到$C$的子矩阵。

$
  S_1 = B_(1 \, 2) - B_(2 \, 2) med med S_2 = A_(1 \, 1) + A_(1 \, 2)\
  S_3 = A_(2 \, 1) + A_(2 \, 2) med med S_4 = B_(2 \, 1) - B_(1 \, 1)\
  S_5 = A_(1 \, 1) + A_(2 \, 2) med med S_6 = B_(1 \, 1) + B_(2 \, 2)\
  S_7 = A_(1 \, 2) - A_(2 \, 2) med med S_8 = B_(2 \, 1) + B_(2 \, 2)\
  S_9 = A_(1 \, 1) - A_(2 \, 1) med med S_10 = B_(1 \, 1) + B_(1 \, 2)\
  P_1 = A_(1 \, 1) dot.op S_1 med med P_2 = S_2 dot.op B_(2 \, 2)\
  P_3 = S_3 dot.op B_(1 \, 1) med med P_4 = A_(2 \, 2) dot.op S_4\
  P_5 = S_5 dot.op S_6 med med P_6 = S_7 dot.op S_8\
  P_7 = S_9 dot.op S_10\
  C_(1 \, 1) = P_5 + P_4 - P_2 + P_6 med med C_(1 \, 2) = P_1 + P_2\
  C_(2 \, 1) = P_3 + P_4 med med C_(2 \, 2) = P_5 + P_1 - P_3 - P_7\
$

对于矩阵规模不是2的幂的情况，只需要补0即可。

类似地，试只用三次乘法完成复数相乘
$\( a + b i \) \( c + d i \) = \( a c - b d \) + \( a d + b c \) i$。

设 $ {alpha = a c\
beta = b d\
gamma = \( a + b \) \( c + d \) $

则：
$ \( a + b i \) \( c + d i \) = \( alpha - beta \) + \( gamma - alpha - beta \) i $

=== 最近点对问题
<最近点对问题>
方法是前面提到过的，按找$x$坐标排序后割开成两部分，最终答案就是$delta_l \, delta_r \, delta'$之间的最小值。但是关键的问题在于$delta'$（左右之间的最小值）该怎么求。

直接用前面求出来的$delta = min \( delta_l \, delta_r \)$，在中线划分出一个带状区域：`[mid_x - delta, mid_x + delta]` 范围内的点。这些点是“可疑分子”，可能构成更小的距离。

然后在带状区域中寻找更小的距离。在矩形带内从下到上滑动一个高为$delta$，长为$2 delta$的矩形。显然对于一个边长为$delta$的正方形来说，两两距离超过边长的点最多有4个，所以最多有8个点能共存于这样高为$delta$长为$2 delta$的矩形，故只需要从矩形带最下方的点开始，对每个点构造这样的矩形，最多枚举7个点即可。

```python
import math

# 辅助函数：计算两点间的欧几里得距离
def dist(p1, p2):
    return math.sqrt((p1[0] - p2[0])**2 + (p1[1] - p2[1])**2)

# 暴力法：当点数很少时（<=3），直接两两比较
def brute_force(points):
    min_dist = float('inf')
    n = len(points)
    for i in range(n):
        for j in range(i + 1, n):
            d = dist(points[i], points[j])
            if d < min_dist:
                min_dist = d
    return min_dist

# 核心递归函数
# points_x: 当前范围内按 X 排序的点列表
# points_y: 当前范围内按 Y 排序的点列表 (这是为了保持 O(N log N) 的关键)
def closest_pair_recursive(points_x, points_y):
    n = len(points_x)
    
    # 1. 递归基：如果点很少，直接用暴力法
    if n <= 3:
        return brute_force(points_x)
    
    # 2. 分解 (Divide)
    mid = n // 2
    mid_point = points_x[mid]
    
    # 将 points_y 分割成左右两部分 (保持 Y 有序)
    # 注意：这里不能简单切片，因为 points_y 是全局 Y 有序的，需要根据 X 坐标判断归属
    left_y = [p for p in points_y if p[0] <= mid_point[0]]
    right_y = [p for p in points_y if p[0] > mid_point[0]]
    
    # 对应的 X 有序列表直接切片即可
    left_x = points_x[:mid]
    right_x = points_x[mid:]
    
    # 3. 解决 (Conquer) - 递归求解左右两边
    delta_left = closest_pair_recursive(left_x, left_y)
    delta_right = closest_pair_recursive(right_x, right_y)
    
    # 取左右两边的较小值作为当前的最小距离 delta
    delta = min(delta_left, delta_right)
    
    # 4. 合并 (Combine) - 处理跨越中线的点对
    
    # 4.1 构建带状区域 T (Strip)
    # 从 Y 有序列表中，筛选出 X 坐标在 [mid_x - delta, mid_x + delta] 范围内的点
    # 这些点是“可疑分子”，可能构成更小的距离
    strip = []
    mid_x = mid_point[0]
    for p in points_y:
        if abs(p[0] - mid_x) < delta:
            strip.append(p)
    
    # 4.2 在带状区域内寻找更小的距离
    # 关键优化：对于 strip 中的每个点，只需要检查它后面最多 7 个点
    min_strip_dist = delta
    for i in range(len(strip)):
        # j 从 i+1 开始，且限制最多检查 7 个点
        # 同时如果 Y 方向距离已经超过 delta，也可以提前停止 (双重保险)
        for j in range(i + 1, min(i + 8, len(strip))):
            if strip[j][1] - strip[i][1] >= delta:
                break
            d = dist(strip[i], strip[j])
            if d < min_strip_dist:
                min_strip_dist = d
    
    # 返回最终的最小值
    return min(min_strip_dist, delta)

# 主函数：初始化排序并调用递归
def closest_pair(points):
    # 预处理：分别生成按 X 和按 Y 排序的列表
    # 这一步只做一次，复杂度 O(N log N)
    points_x = sorted(points, key=lambda p: p[0])
    points_y = sorted(points, key=lambda p: p[1])
    
    return closest_pair_recursive(points_x, points_y)
```

== 本章作业
<本章作业>
=== 快排空间复杂度
<快排空间复杂度>
证明算法QUICKSORT的空间复杂度在$Theta \( log n \)$与$Theta \( n \)$之间变动。并计算该算法的平均空间复杂度是多少？

快速排序的空间复杂度主要由递归调用栈的深度（栈中存储的是枢轴量）决定，而递归深度取决于划分的平衡性。

快速排序的平均空间复杂度由递归树的平均深度决定。通过分析划分的期望行为，可以证明平均深度为
$O \( log n \)$。

划分点是随机选择的，划分后左右子数组大小的比例为任意
$\( k \, n - k - 1 \)$ 的概率均等。设 $D \( n \)$
为递归树深度的期望值，满足以下递推关系：
$ D \( n \) = 1 + 1 / n sum_(k = 0)^(n - 1) max \( D \( k \) \, D \( n - k - 1 \) \) $
由于 $D \( k \)$ 和 $D \( n - k - 1 \)$ 对称，可简化为：
$ D \( n \) = 1 + 2 / n sum_(k = floor.l n \/ 2 floor.r)^(n - 1) D \( k \) $
假设 $D \( k \) lt.eq c log k$ 对所有 $k < n$ 成立，则：
$ D \( n \) lt.eq 1 + frac(2 c, n) sum_(k = floor.l n \/ 2 floor.r)^(n - 1) log k $
通过积分近似求和（$sum log k approx n log n - n$），可得：
$ D \( n \) lt.eq 1 + frac(2 c, n) (n log n - n / 2 log n / 2) approx c log n $
因此，$D \( n \) = O \( log n \)$。

=== 多选问题
<多选问题>
设 $S$ 是包含 $n$ 个不等数的集合，给定整数
$r$（$1 lt.eq r lt.eq n$），$K = { k_1 \, k_2 \, dots.h \, k_r }$ 且
$1 lt.eq k_1 < k_2 < dots.h < k_r lt.eq n$。要求在 $S$ 中找出第 $k_1$
小，第 $k_2$ 小，$dots.h$，第 $k_r$ 小的 $r$
个元素。例如，$r = 3$，$K = { 2 \, 4 \, 7 }$，则输出 $S$ 中的第 $2$
小，第 $4$ 小，第 $7$ 小的元素。当 $r = 1$
时，该问题就是一般选择问题。当 $r = n$ 时，该问题就变成了排序问题。

+ 设计一个最坏情况下时间复杂度为 $O \( n r \)$ 的算法。

+ 若 $r > 1$，设计一个最坏情况下时间复杂度为 $O \( n log r \)$ 的算法。

时间复杂度$O \( n r \)$的算法

#block[
  对$K$进行排序，确保$k_1 < k_2 < dots.h.c < k_r$
  初始化结果数组$R \[ 1 . . r \]$ $R$

]
时间复杂度$O \( n log r \)$的算法

#block[
  对$K$进行排序，确保$k_1 < k_2 < dots.h.c < k_r$
  $k_(m i d) arrow.l k_(floor.l r \/ 2 floor.r)$ $p i v o t arrow.l$
  SELECT($S$, $k_(m i d)$) 将$S$划分为：
  $L arrow.l { x in S divides x < p i v o t }$
  $E arrow.l { x in S divides x = p i v o t }$
  $G arrow.l { x in S divides x > p i v o t }$ 初始化子问题的$K$集合：
  $K_L arrow.l { k_i in K divides k_i < k_(m i d) }$
  $K_G arrow.l { k_i in K divides k_i > k_(m i d) }$ 递归解决子问题：
  $R_L arrow.l$ MultipleSelectOptimized($L$, $K_L$, $\| L \|$,
  $\| K_L \|$) $R_G arrow.l$ MultipleSelectOptimized($G$,
  $K_G - \| L \| - \| E \|$, $\| G \|$, $\| K_G \|$)
  $R_L union { p i v o t } union R_G$

]
+ #strong[基本情况处理]：

  - 若$r = 1$，直接调用SELECT算法（时间复杂度$O \( n \)$）返回第$k_1$小的元素

+ #strong[预处理]：

  - 对$K$排序，确保$k_1 < k_2 < dots.h.c < k_r$

+ #strong[选取枢纽元]：

  - 计算$K$的中位数位置：$k_(m i d) = k_(floor.l r \/ 2 floor.r)$

  - 使用SELECT算法在$S$中找到第$k_(m i d)$小的元素$p i v o t$

+ #strong[划分数组]：

  - $L = { x in S divides x < p i v o t }$

  - $E = { x in S divides x = p i v o t }$

  - $G = { x in S divides x > p i v o t }$

+ #strong[递归处理子问题]：

  - 左子问题$K_L = { k_i in K divides k_i < k_(m i d) }$：在$L$中递归求解

  - 右子问题$K_G = { k_i in K divides k_i > k_(m i d) }$：在$G$中递归求解，调整查询排名$k'_i = k_i - \| L \| - \| E \|$

+ #strong[合并结果]：

  - 返回$R_L union { p i v o t } union R_G$

时间复杂度分析

- 递归深度：$O \( log r \)$（每次$K$规模减半）

- 每层工作量：$O \( n \)$（SELECT和划分）

- 总时间复杂度：$O \( n log r \)$
