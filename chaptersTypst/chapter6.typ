#import "@local/ysz_tools:0.1.0": *
#show: conf

= chapter6: 图的遍历
<chapter6-图的遍历>
== DFS与BFS
<DFS与BFS>

#algorithm[DFS][
  ```python
  visited = [False] * n
  def dfs(u):
    visited[u] = True
    for v in graph[u]:
      if not visited[v]:
        dfs(v)
  ```
]

#algorithm[BFS][
  ```python
  visited = [False] * n
  def bfs(start):
    queue = queue([start])
    visited[start] = True
    while queue:
      u = queue.pop()
      for v in graph[u]:
        if not visited[v]:
          visited[v] = True
          queue.append(v)
  ```
]

DFS与BFS的想必大家都不陌生，图上DFS与图上BFS的执行过程也很简明，在此不再赘述。

#unim[
  DFS的特点是单线深入，因而适用于查找图上的环——当将要被访问的节点已经被访问过时，就说明找到了一个环。基于这种特点，我们可以构建出DFS序这一概念：`dfn[u]`表示节点`u`被访问的时间戳，`low[u]`表示在DFS过程中能够通过回边访问到的最早的时间戳。通过比较`dfn[u]`和`low[v]`（其中`v`是`u`的一个子节点），我们可以判断是否存在割点、桥等重要结构。
  
  DFS是Tarjan等算法的基础。

  BFS的特点是多线并行，因而适用于查找图上的最短路径——当一个节点被访问时，它的所有邻居节点都会被塞入将要访问的队列，这样就保证了第一次访问到某个节点时所经过的路径是最短的。基于这种特点，我们可以构建出无权图（每两条边只有联通或不联通两种状态）上的朴素最短路算法：当前节点为`u`，当前邻居节点为`v`，则`dist[v] = dist[u] + 1`，时间复杂度为 $O(V + E)$。
  
  BFS是A\*等算法的基础。
]
  // #table(
  // columns: 3,
  // align: center,
  // [算法], [DFS], [BFS],
  // [数据结构], [栈], [队列],
  // [遍历顺序], [前序], [层序],
  // [时间复杂度], [$O(V + E)$], [$O(V + E)$],
  // )

== tarjan算法
<tarjan算法>



== A\*算法
<a-star算法>



== 其他应用
=== 判定图是否有环

进行DFS遍历全图，如果在访问一个节点时发现它已经被访问过了，那么就说明存在环；否则不存在环。

=== 拓扑排序

#definition[拓扑序][在有向无环图（DAG）中，如果对于每一条有向边$(u, v)$，节点$u$在序列中都出现在节点$v$之前，那么这个序列就是一个合法的拓扑序。]

对于有向无环图（DAG），我们可以进行DFS遍历全图，并在访问完一个节点的所有邻居节点后（回溯过程）将该节点加入结果列表中。最终得到的结果列表就是一个合法的拓扑序的逆序。

#unim[不难得出，如果建原图的反图（将每条边的方向反转），则反图的DFS序就是原图的拓扑序。]