#columns(2, gutter: 8pt)[
```python
# 全局变量初始化
index = 0
dfn = []      # 时间戳
low = []      # 追溯值
visited = []  # 记录节点是否被访问过

# 【场景专用变量】
# 1. 求 SCC 专用
stack = []
in_stack = [] # 记录节点是否在栈中
scc_list = [] # 存储最终的各个 SCC

# 2. 求割点/割边专用
is_cut_vertex = [] # 标记哪些节点是割点
bridges = []       # 存储最终的割边 (u, v)

def tarjan_dfs(u, parent=-1):
    global index
    

# 位置 1：初见节点，初始化时间戳与入栈

    index += 1
    dfn[u] = low[u] = index
    visited[u] = True
    
    # [SCC 业务]：进栈
    stack.append(u)
    in_stack[u] = True
    
    child_count = 0 # [割点业务]：记录在 DFS 树中的子节点个数
    
    # 遍历当前节点的所有邻居
    for v in adj[u]:
        # [割点/割边业务]：无向图防止沿原路直接连回亲生父亲
        if v == parent:
            continue
            
        if not visited[v]:
            # 树边分支 
            child_count += 1
            tarjan_dfs(v, u) # 递归向下探测
            
            
            # 位置 2：回溯时分（从子树探路回来）
            
            # 父亲根据儿子探测到的最高祖先，更新自己的 low 值
            low[u] = min(low[u], low[v])
            
            # [割边业务判定]：儿子连父亲本身都回不去
            if low[v] > dfn[u]:
                bridges.append((u, v))
                
            # [割点业务判定]：非根节点情况下，儿子最多只能回到父亲
            if parent != -1 and low[v] >= dfn[u]:
                is_cut_vertex[u] = True
                
        else:
            # 非树边分支
            
            # 位置 3：遭遇已访问节点，尝试通过“抄近路”更新
            
            # [SCC 业务]：有向图要求目标必须在栈中
            # [割点/割边业务]：无向图直接满足（此处等价于 low[u] = min(low[u], dfn[v])）
            if in_stack[v] or (无向图模式): 
                low[u] = min(low[u], dfn[v])

    
    # 位置 4：整个子树结算完毕，准备离开当前节点
    
    
    # [割点业务特判]：如果是根节点，且在 DFS 树中拥有超过 1 个独立子树
    if parent == -1 and child_count >= 2:
        is_cut_vertex[u] = True

    # [SCC 业务判定]：如果当前节点是该强连通分量的“终极大 boss”
    if low[u] == dfn[u]:
        current_scc = []
        while True:
            top = stack.pop()
            in_stack[top] = False
            current_scc.append(top)
            if top == u:
                break
        scc_list.append(current_scc) # 收割一整个 SCC
```
]