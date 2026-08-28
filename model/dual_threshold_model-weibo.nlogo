turtles-own
[
  node-clustering-coefficient
  distance-from-other-turtles   ;; list of distances of this node from other turtles
  probility-frome-other-turtles
  neighbor-list
  list1
  length1
;;P-ID
Gender
;;Age
FID
  vijs
  P    ;;成为朋友的概率
 ;; R    ;;关系系数
 ;; M   ;;表达程度
  Oa   ;;内隐观点值
  Ob   ;;外显观点
  u   ;;坚持度
  w ;;信任阈值
 ;; Pl   ;;关系列表
]

links-own
[
  rewired?
  R
  rr   ;;关系系数
]
breed [fones fone]
breed [ftwos ftwo]
breed [fthrees fthree]
breed [ffours ffour]
breed [ffives ffive]
breed [fsixs fsix]
breed [fsevens fseven]

globals
[
  clustering-coefficient               ;; the clustering coefficient of the network; this is the
                                       ;; average of clustering coefficients of all turtles
  average-path-length                  ;; average path length of the network
  clustering-coefficient-of-lattice    ;; the clustering coefficient of the initial lattice
  average-path-length-of-lattice       ;; average path length of the initial lattice
  infinity                             ;; a very large number.
                                         ;; used to denote distance between two turtles which
                                         ;; don't have a connected or unconnected path between them
  ;;jjfzsl   ;;激进分子数量

]


to setup
  clear-all
  set-default-shape turtles "circle"
  set infinity 99999
  ;; make the initial network of two turtles and an edge
  ;;setup-turtles
  setup-fones
  setup-fones
  setup-ftwos
  setup-fthrees
  setup-ffours
 setup-ffives
  setup-fsixs
  setup-fsevens
  find-friends
  set clustering-coefficient-of-lattice clustering-coefficient
  set average-path-length-of-lattice average-path-length
  find-clustering-coefficient
  ;;find-path-lengths
  ask links [ set rr round 10 * R ]
   ask turtles
  [
    set neighbor-list link-neighbors
    set list1 [who] of neighbor-list ;;邻居号列表
    set length1 length list1  ;;邻居号列表的长度
    set oa random-float 0.7
    set oa precision oa 2    ;;观点
    set ob random-float 0.7
    set ob precision ob 2    ;;观点
    set u random-float 1
    set u precision u 1    ;;坚持度
  ;; set u uu  ;;坚持度调整
   ;; if u > 0.8 [set shape "arrow"
   ;; set color red]
  ]

   ask n-of jjfzsl turtles
    [ set oa 1
      set ob 1
     set u 1
  set color yellow]  ;;极端个体
  ;  ask n-of (jjfzsl / 2) ftwos
  ;  [ set o 1
  ;    set u 1]  ;;极端个体
  ; ask n-of (jjfzsl / 2) fthrees
   ; [ set o 1
   ;   set u 1]  ;;极端个体
  ask fones
  [
  ]
   ask ftwos
  [
  ]
  ask fthrees
  [
  ]
;;  ask n-of 100 ffours
 ; [
  ;;   set o 1
  ;;   set u 1
 ; ]
  ask ffives
  [
  ]
  ask fsixs
  [
  ]
  ask fsevens
  [
  ]
  reset-ticks

   ;;let connected? do-calculations
end

to  setup-fones
  let n 1
  while [n < 10]
  [ create-fones 1
    [ set color red
      setxy random-xcor random-ycor
      set Gender random 2
      set FID n
    ]
    set n n + 1
  ]
end

to  setup-ftwos
  let n 10
  while [n > 9 and n < 110]
  [ create-ftwos 2
    [ set color red
      setxy random-xcor random-ycor
      set Gender random 2
      set FID n

    ]
    set n n + 1
  ]
  foreach sort ftwos [
  the-ftwos -> ask the-ftwos [
      let m [FID] of the-ftwos
      create-links-with other ftwos with [ FID = m ][set R 1]
      move-to one-of other ftwos with [ FID = m ]
      fd 3
    ]
  ]


end

to  setup-fthrees
  let n 110
  while [n > 109 and n < 195]
  [ create-fthrees 3
    [ set color red
      setxy random-xcor random-ycor
      set Gender random 2
      set FID n
    ]
    set n n + 1
  ]
  foreach sort fthrees [
  the-fthrees -> ask the-fthrees [
      let m [FID] of the-fthrees
      create-links-with other fthrees with [ FID = m ][set R 1]
      move-to one-of other fthrees with [ FID = m ]
      fd 3
    ]
  ]
end

to  setup-ffours
  let n 210
  while [n > 211 and n < 215]
  [ create-ffours 4
    [ set color red
      setxy random-xcor random-ycor
      set Gender random 2
      set FID n
    ]
    set n n + 1
  ]
   foreach sort ffours [
  the-ffours -> ask the-ffours [
      let m [FID] of the-ffours
      create-links-with other ffours with [ FID = m ][set R 1]
      move-to one-of other ffours with [ FID = m ]
      fd 3
    ]
  ]
end

to  setup-ffives
  let n 215
  while [n > 216 and n < 216]
  [ create-ffives 50
    [ set color red
      setxy random-xcor random-ycor
      set Gender random 2
      set FID n
    ]
    set n n + 1
  ]
   foreach sort ffives [
  the-ffives -> ask the-ffives [
      let m [FID] of the-ffives
      create-links-with other ffives with [ FID = m ][set R 1]
      move-to one-of other ffives with [ FID = m ]
      fd 3
    ]
  ]
end

to  setup-fsixs
  let n 216
  while [n > 217 and n < 217]
  [ create-fsixs 6
    [ set color red
      setxy random-xcor random-ycor
      set Gender random 2
      set FID n
    ]
    set n n + 1
  ]
  foreach sort fsixs [
  the-fsixs -> ask the-fsixs [
      let m [FID] of the-fsixs
      create-links-with other fsixs with [ FID = m ][set R 1]
      move-to one-of other fsixs with [ FID = m ]
      fd 3
    ]
  ]
end

to  setup-fsevens
  create-fsevens 7
    [ set color red
      setxy random-xcor random-ycor
      set Gender random 2
      set FID 218
    ]
   foreach sort fsevens [
  the-fsevens -> ask the-fsevens [
      let m [FID] of the-fsevens
      create-links-with other fsevens with [ FID = m ][set R 1]
      move-to one-of other fsevens with [ FID = m ]
      fd 3
    ]
  ]
end

to go
  ; find-path-lengths
  ;find-friends
  yanhua

  tick
  if layout? [ layout ]
end


to yanhua
 let node-count count turtles
 let node1 one-of turtles
 let node2 one-of turtles
 let n 0
 let m 0


 while [n < node-count]
  [
  set node1 turtle n
    ask node1 [
  ifelse length1 = 0
      [ set m 0]
      [ set m length1 ]
  let i 0
  let j 0
      let pp 0
      let ppp 0
  let ii 0   ;;需要思考
  let jj 0
  let r2 0
  let m1 m - 1
    ifelse m = 0
    [
      ifelse [u] of node1 > 0.5
      [ set oa oa
         set ob u * oa + (1 - u) * ppp]
      [ ;set o u * o + (1 - u) * (1 - g ) * l
         set oa oa + (1 - u) * (1 - g ) * l
          set ob u * oa + (1 - u) * ppp
        if oa < 0 [set oa 0]
        if oa > 1 [set oa 1]
        if ob < 0 [set ob 0]
        if ob > 1 [set ob 1]]
    ]
    [  ;;集不空

       ;; set list1 [who] of neighbor-list
        while [m1 > -1]
       [;;while [m1 > -1]
        let m11 item m1 list1
        set node2 turtle m11
          ;;let n1 [who] of node1
         ;; let n2 [who] of node2
        let r1 [ R ] of link n m11

          ifelse r1 < 0.6
          [set r2 0.1]
          [ ifelse r1 < 0.65
            [ set r2 0.3]
            [ ifelse r1 < 0.75
              [ set r2 0.5]
              [ ifelse r1 < 0.85
                [set r2 0.7]
                [set r2 0.9]
              ]
            ]
          ];; 设置表达程度r2

          ifelse r1 < s ;;信任阈值
          [ set ii ii + 1
            set i i + r2 * ([ob] of node2 - [oa] of node1)
          Set ppp pp + r2 * [ob] of node2];;不亲近的
          [ set jj jj + 1
            set j j + r2 * ([ob] of  node2 - [oa] of node1)
          Set ppp pp + r2 * [ob] of node2];;亲近的
       set m1 m1 - 1
        ]




      ifelse [u] of node1 > 0.5
      [
        ifelse jj = 0
          [  set oa oa
        set ob u * oa + (1 - u) * ppp          ]
          [
            ;set o u * o + (1 - u) * g * j / (2 * jj)
             set oa  oa + (1 - u) * g * j / (2 * jj)
set ob u * oa + (1 - u) * ppp
          ]
        if oa < 0 [set oa 0]
        if oa > 1 [set oa 1]
          if ob < 0 [set ob 0]
        if ob > 1 [set ob 1]
        if  oa > 0.9 [set color yellow ]
      ]
        [   if jj = 0
          [ ;set o u * o + (1 - u) * (  g * i /( 2 * ii )+ (1 - g) * l)
            set oa  oa + (1 - u) * (  g * i /( 2 * ii )+ (1 - g) * l)
            set ob u * oa + (1 - u) * ppp
          ]
          if ii = 0
           [ ;set o u * o + (1 - u) * (g * j / (2 * jj )+  (1 - g) * l)
            set oa  oa + (1 - u) * (g * j / (2 * jj )+  (1 - g) * l)
              set ob u * oa + (1 - u) * ppp
          ]
          if ii != 0 and jj != 0
          [ ;set o u * o + (1 - u) * (g * j / (2 * jj )+ g * i /( 2 * ii )+ (1 - g) * l)
            set oa  oa + (1 - u) * (g * j / (2 * jj )+ g * i /( 2 * ii )+ (1 - g) * l)
          set ob u * oa + (1 - u) * ppp
          ]
      if oa < 0 [set oa 0]
        if oa > 1 [set oa 1]
          if ob < 0 [set ob 0]
        if ob > 1 [set ob 1]
        if  oa > 0.9 [set color yellow ]

      ]


    ];;集不空
  set n n + 1
  ]
  ]
end



















to resize-nodes
  ifelse all? turtles [size <= 1]
  [
  ask turtles [ set size sqrt count link-neighbors ]
  ]
  [
    ask turtles [ set size 1 ]
  ]
end

to find-friends
  ask turtles
  [
    set probility-frome-other-turtles []
  ]
 let n 0
 let m 0
 let d 0
 let node-count count turtles
 let node1 one-of turtles
 let node2 one-of turtles
  while [n < node-count]
  [
    set m 0 ;n + 1
    while [m < node-count]
    [ set node1 turtle n
      set node2 turtle m
      ifelse m = n
      [ ask node1 [
        set probility-frome-other-turtles lput 0 probility-frome-other-turtles
        ]
      ];;如果m=n
      [ ;;如果m不等于n
        ifelse [ link-neighbor? node1 ] of node2
        [
        ifelse [FID] of turtle n = [FID] of turtle m
        [ask node1
            [
        set probility-frome-other-turtles lput 1 probility-frome-other-turtles
        ]
        ];;如果属于一个家庭
          [
            ask node1
            [
              set probility-frome-other-turtles lput  [R] of link m n  probility-frome-other-turtles
          ]
        ];;如果不属于一个家庭
        ] ;;是邻居的if
        [;;不是邻居

          ifelse [Gender] of node1 = [Gender] of node2
          [ ask node1 [set vijs 0.5]]
          [ ;;ask node1 [set vijs 1 / ( 1 + exp ( -0.5 ) )  ]
            ask node1 [set vijs 0.2 ]  ]
          ask node1 [
            set d distance node2
            let vijd 1 /(1 + 0.041 * (  d  ^ 0.969)) ;;有问题
           ;; let vijd 1 /(1 + 0.41 * (  d  ^ 0.969)) ;;有问题
            let vij vijs + vijd
           let pij exp (vij) / ( exp (vij) + exp (1.57) )
         ;; let pij 0
          ;;  ifelse vij > 1
          ;;  [ set pij 1]
          ;;  [set pij vij - 0.3]
           set pij (pij - 0.4 ) * 10 ;;什么意思
            if pij > 1 [set pij 1]
           ;; let wiring-probability random-float 1   ;满足什么分布待定，先随机
            ifelse pij < gxyz ;;wiring-probability
            [ set probility-frome-other-turtles lput pij probility-frome-other-turtles]
            [ set probility-frome-other-turtles lput pij probility-frome-other-turtles
              create-link-with node2 [set R pij ]]
          ]
        ];;不是邻居结束
      ]
      set m m + 1
    ]
    set n n + 1
  ]
end



to layout
  ;; the number 3 here is arbitrary; more repetitions slows down the
  ;; model, but too few gives poor layouts
  repeat 3 [
    ;; the more turtles we have to fit into the same amount of space,
    ;; the smaller the inputs to layout-spring we'll need to use
    let factor sqrt count turtles
    ;; numbers here are arbitrarily chosen for pleasing appearance
    layout-spring turtles links (1 / factor) (7 / factor) (1 / factor)
    display  ;; for smooth animation
  ]
  ;; don't bump the edges of the world
  let x-offset max [xcor] of turtles + min [xcor] of turtles
  let y-offset max [ycor] of turtles + min [ycor] of turtles
  ;; big jumps look funny, so only adjust a little each time
  set x-offset limit-magnitude x-offset 0.1
  set y-offset limit-magnitude y-offset 0.1
  ask turtles [ setxy (xcor - x-offset / 2) (ycor - y-offset / 2) ]
end

to-report limit-magnitude [number limit]
  if number > limit [ report limit ]
  if number < (- limit) [ report (- limit) ]
  report number
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Clustering computations ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

to-report in-neighborhood? [ hood ]
  report ( member? end1 hood and member? end2 hood )
end


to find-clustering-coefficient
  ifelse all? turtles [count link-neighbors <= 1]
  [
    ;; it is undefined
    ;; what should this be?
    set clustering-coefficient 0
  ]
  [
    let total 0
    ask turtles with [ count link-neighbors <= 1]
      [ set node-clustering-coefficient "undefined" ]
    ask turtles with [ count link-neighbors > 1]
    [
      let hood link-neighbors
      set node-clustering-coefficient (2 * count links with [ in-neighborhood? hood ] /
                                         ((count hood) * (count hood - 1)) )
      ;; find the sum for the value at turtles
      set total total + node-clustering-coefficient
    ]
    ;; take the average
    set clustering-coefficient total / count turtles with [count link-neighbors > 1]
  ]
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Path length computations ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Implements the Floyd Warshall algorithm for All Pairs Shortest Paths
;; It is a dynamic programming algorithm which builds bigger solutions
;; from the solutions of smaller subproblems using memoization that
;; is storing the results.
;; It keeps finding incrementally if there is shorter path through
;; the kth node.
;; Since it iterates over all turtles through k,
;; so at the end we get the shortest possible path for each i and j.

to find-path-lengths
  ;; reset the distance list
  ask turtles
  [
    set distance-from-other-turtles []
  ]

  let i 0
  let j 0
  let k 0
  let node1 one-of turtles
  let node2 one-of turtles
  let node-count count turtles
  ;; initialize the distance lists
  while [i < node-count]
  [
    set j 0
    while [j < node-count]
    [
      set node1 turtle i
      set node2 turtle j
      ;; zero from a node to itself
      ifelse i = j
      [
        ask node1 [
          set distance-from-other-turtles lput 0 distance-from-other-turtles
        ]
      ]
      [
        ;; 1 from a node to it's neighbor
        ifelse [ link-neighbor? node1 ] of node2
        [
          ask node1 [
            set distance-from-other-turtles lput 1 distance-from-other-turtles
          ]
        ]
        ;; infinite to everyone else
        [
          ask node1 [
            set distance-from-other-turtles lput infinity distance-from-other-turtles
          ]
        ]
      ]
      set j j + 1
    ]
    set i i + 1
  ]
  set i 0
  set j 0
  let dummy 0
  while [k < node-count]
  [
    set i 0
    while [i < node-count]
    [
      set j 0
      while [j < node-count]
      [
        ;; alternate path length through kth node
        set dummy ( (item k [distance-from-other-turtles] of turtle i) +
                    (item j [distance-from-other-turtles] of turtle k))
        ;; is the alternate path shorter?
        if dummy < (item j [distance-from-other-turtles] of turtle i)
        [
          ask turtle i [
            set distance-from-other-turtles replace-item j distance-from-other-turtles dummy
          ]
        ]
        set j j + 1
      ]
      set i i + 1
    ]
    set k k + 1
  ]

  let num-connected-pairs sum [length remove infinity (remove 0 distance-from-other-turtles)] of turtles

  ;; In a connected network on N nodes, we should have N(N-1) measurements of distances between pairs,
  ;; and none of those distances should be infinity.
  ;; If there were any "infinity" length paths between nodes, then the network is disconnected.
  ;; In that case, calculating the average-path-length doesn't really make sense.
 ; ifelse ( num-connected-pairs != (count turtles * (count turtles - 1) ))
 ; [
 ;     set average-path-length infinity
      ;; report that the network is not connected
      ;;set connected? false
 ; ]
 ; [
    set average-path-length (sum [sum distance-from-other-turtles] of turtles) / (num-connected-pairs)
  ;]
end


to-report do-calculations

  ;; set up a variable so we can report if the network is disconnected
  let connected? true

  ;; find the path lengths in the network
  find-path-lengths

  let num-connected-pairs sum [length remove infinity (remove 0 distance-from-other-turtles)] of turtles

  ;; In a connected network on N nodes, we should have N(N-1) measurements of distances between pairs,
  ;; and none of those distances should be infinity.
  ;; If there were any "infinity" length paths between nodes, then the network is disconnected.
  ;; In that case, calculating the average-path-length doesn't really make sense.
  ifelse ( num-connected-pairs != (count turtles * (count turtles - 1) ))
  [
      set average-path-length infinity
      ;; report that the network is not connected
      set connected? false
  ]
  [
    set average-path-length (sum [sum distance-from-other-turtles] of turtles) / (num-connected-pairs)
  ]
  ;; find the clustering coefficient and add to the aggregate for all iterations
  find-clustering-coefficient

  ;; report whether the network is connected or not
  report connected?
end


to save-file

  file-open "shuju.txt"
  file-print count turtles with [oa > 0.8]
  file-close

end
@#$#@#$#@
GRAPHICS-WINDOW
531
10
779
259
-1
-1
3.93443
1
10
1
1
1
0
0
0
1
-30
30
-30
30
0
0
1
ticks
30.0

BUTTON
6
10
72
43
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
7
52
110
97
NIL
count turtles
17
1
11

BUTTON
80
10
222
43
NIL
repeat 1000 [go]
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
231
10
345
43
NIL
resize-nodes
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SWITCH
119
57
225
90
layout?
layout?
1
1
-1000

MONITOR
7
100
210
145
NIL
count turtles with [Gender = 1]
17
1
11

MONITOR
7
148
209
193
NIL
count turtles with [Gender = 0]
17
1
11

MONITOR
7
195
193
240
NIL
count links with [R != 1]
17
1
11

MONITOR
6
244
95
289
NIL
count links
17
1
11

MONITOR
6
292
171
337
NIL
clustering-coefficient
17
1
11

PLOT
217
100
417
250
degree distribution
degree
NUM of turtles
1.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 1 -16777216 true "" "if not plot? [ stop ]\nlet max-degree max [count link-neighbors] of turtles\nplot-pen-reset  ;; erase what we plotted before\nset-plot-x-range 1 (max-degree + 1)  ;; + 1 to make room for the width of the last bar\nhistogram [count link-neighbors] of turtles"

SWITCH
235
57
338
90
plot?
plot?
0
1
-1000

PLOT
281
108
692
409
degree distributiom (log-log)
log(degree)
log(# of nodes)
0.0
0.3
0.0
0.3
true
false
"" ""
PENS
"default" 1.0 2 -16777216 true "" "if not plot? [ stop ]\nlet max-degree max [count link-neighbors] of turtles\n;; for this plot, the axes are logarithmic, so we can't\n;; use \"histogram-from\"; we have to plot the points\n;; ourselves one at a time\nplot-pen-reset  ;; erase what we plotted before\n;; the way we create the network there is never a zero degree node,\n;; so start plotting at degree one\nlet degree 1\nwhile [degree <= max-degree] [\n  let matches turtles with [count link-neighbors = degree]\n  if any? matches\n    [ plotxy log degree 10\n             log (count matches) 10 ]\n  set degree degree + 1\n]"

MONITOR
6
340
150
385
NIL
average-path-length
17
1
11

PLOT
783
10
983
160
plot 1
rr
num
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 1 -16777216 true "" "if not plot? [ stop ]\nlet max-r max [ rr ] of links\nplot-pen-reset  ;; erase what we plotted before\nset-plot-x-range 1 (max-r + 1)  ;; + 1 to make room for the width of the last bar\nhistogram [rr] of links"

SLIDER
350
10
522
43
l
l
0
0.01
4.0E-4
0.0004
1
NIL
HORIZONTAL

SLIDER
357
56
529
89
g
g
0
1
0.5
0.1
1
NIL
HORIZONTAL

SLIDER
358
149
530
182
s
s
0
1
0.65
0.01
1
NIL
HORIZONTAL

PLOT
346
221
728
489
NIL
time
o
0.0
1000.0
0.0
1.0
false
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot [oa] of turtle 0"
"pen-1" 1.0 0 -2674135 true "" "plot [ob] of turtle 0"
"pen-2" 1.0 0 -16777216 true "" "plot [oa] of turtle 2"
"pen-3" 1.0 0 -2674135 true "" "plot [ob] of turtle 2"
"pen-4" 1.0 0 -16644859 true "" "plot [oa] of turtle 4"
"pen-5" 1.0 0 -2674135 true "" "plot [ob] of turtle 4"
"pen-6" 1.0 0 -16645118 true "" "plot [oa] of turtle 6"
"pen-7" 1.0 0 -2674135 true "" "plot [ob] of turtle 6"
"pen-8" 1.0 0 -16710398 true "" "plot [oa] of turtle 8"
"pen-9" 1.0 0 -2674135 true "" "plot [ob] of turtle 8"
"pen-10" 1.0 0 -16710398 true "" "plot [oa] of turtle 10"
"pen-11" 1.0 0 -2674135 true "" "plot [ob] of turtle 10"
"pen-12" 1.0 0 -16777216 true "" "plot [oa] of turtle 12"
"pen-13" 1.0 0 -2674135 true "" "plot [ob] of turtle 12"
"pen-14" 1.0 0 -16777216 true "" "plot [oa] of turtle 14"
"pen-15" 1.0 0 -2674135 true "" "plot [ob] of turtle 14"
"pen-16" 1.0 0 -16777216 true "" "plot [oa] of turtle 16"
"pen-17" 1.0 0 -2674135 true "" "plot [ob] of turtle 16"
"pen-18" 1.0 0 -16777216 true "" "plot [oa] of turtle 18"
"pen-19" 1.0 0 -2674135 true "" "plot [ob] of turtle 18"
"pen-20" 1.0 0 -16777216 true "" "plot [oa] of turtle 20"
"pen-21" 1.0 0 -2674135 true "" "plot [ob] of turtle 20"
"pen-22" 1.0 0 -16777216 true "" "plot [oa] of turtle 22"
"pen-23" 1.0 0 -2674135 true "" "plot [ob] of turtle 22"
"pen-24" 1.0 0 -16777216 true "" "plot [oa] of turtle 24"
"pen-25" 1.0 0 -2674135 true "" "plot [ob] of turtle 24"
"pen-26" 1.0 0 -16777216 true "" "plot [oa] of turtle 26"
"pen-27" 1.0 0 -2674135 true "" "plot [ob] of turtle 26"
"pen-28" 1.0 0 -16777216 true "" "plot [oa] of turtle 28"
"pen-29" 1.0 0 -2674135 true "" "plot [ob] of turtle 28"
"pen-30" 1.0 0 -16777216 true "" "plot [oa] of turtle 30"
"pen-31" 1.0 0 -2674135 true "" "plot [ob] of turtle 30"
"pen-32" 1.0 0 -16777216 true "" "plot [oa] of turtle 331"
"pen-33" 1.0 0 -2674135 true "" "plot [ob] of turtle 331"
"pen-34" 1.0 0 -16777216 true "" "plot [oa] of turtle 333"
"pen-35" 1.0 0 -2674135 true "" "plot [ob] of turtle 333"
"pen-36" 1.0 0 -16777216 true "" "plot [oa] of turtle 335"
"pen-37" 1.0 0 -2674135 true "" "plot [ob] of turtle 335"
"pen-38" 1.0 0 -16777216 true "" "plot [oa] of turtle 337"
"pen-39" 1.0 0 -2674135 true "" "plot [ob] of turtle 337"
"pen-40" 1.0 0 -16777216 true "" "plot [oa] of turtle 339"
"pen-41" 1.0 0 -2674135 true "" "plot [ob] of turtle 339"
"pen-42" 1.0 0 -16777216 true "" "plot [oa] of turtle 341"
"pen-43" 1.0 0 -2674135 true "" "plot [ob] of turtle 341"
"pen-44" 1.0 0 -16777216 true "" "plot [oa] of turtle 343"
"pen-45" 1.0 0 -2674135 true "" "plot [ob] of turtle 343"
"pen-46" 1.0 0 -16777216 true "" "plot [oa] of turtle 345"
"pen-47" 1.0 0 -2674135 true "" "plot [ob] of turtle 345"
"pen-48" 1.0 0 -16777216 true "" "plot [oa] of turtle 347"
"pen-49" 1.0 0 -2674135 true "" "plot [ob] of turtle 347"
"pen-50" 1.0 0 -16777216 true "" "plot [oa] of turtle 349"
"pen-51" 1.0 0 -2674135 true "" "plot [ob] of turtle 349"
"pen-52" 1.0 0 -16777216 true "" "plot [oa] of turtle 351"
"pen-53" 1.0 0 -2674135 true "" "plot [ob] of turtle 351"
"pen-54" 1.0 0 -16777216 true "" "plot [oa] of turtle 353"
"pen-55" 1.0 0 -2674135 true "" "plot [ob] of turtle 353"
"pen-56" 1.0 0 -16777216 true "" "plot [oa] of turtle 355"
"pen-57" 1.0 0 -2674135 true "" "plot [ob] of turtle 355"
"pen-58" 1.0 0 -16777216 true "" "plot [oa] of turtle 357"
"pen-59" 1.0 0 -2674135 true "" "plot [ob] of turtle 357"
"pen-60" 1.0 0 -16777216 true "" "plot [oa] of turtle 359"
"pen-61" 1.0 0 -2674135 true "" "plot [ob] of turtle 359"
"pen-62" 1.0 0 -16777216 true "" "plot [oa] of turtle 361"
"pen-63" 1.0 0 -2674135 true "" "plot [ob] of turtle 361"
"pen-64" 1.0 0 -16777216 true "" "plot [oa] of turtle 363"
"pen-65" 1.0 0 -2674135 true "" "plot [ob] of turtle 363"
"pen-66" 1.0 0 -16777216 true "" "plot [oa] of turtle 365"
"pen-67" 1.0 0 -2674135 true "" "plot [ob] of turtle 365"
"pen-68" 1.0 0 -16777216 true "" "plot [oa] of turtle 367"
"pen-69" 1.0 0 -2674135 true "" "plot [ob] of turtle 367"
"pen-70" 1.0 0 -16777216 true "" "plot [oa] of turtle 369"
"pen-71" 1.0 0 -2674135 true "" "plot [ob] of turtle 369"
"pen-72" 1.0 0 -16777216 true "" "plot [oa] of turtle 371"
"pen-73" 1.0 0 -2674135 true "" "plot [ob] of turtle 371"
"pen-74" 1.0 0 -16777216 true "" "plot [oa] of turtle 373"
"pen-75" 1.0 0 -2674135 true "" "plot [ob] of turtle 373"
"pen-76" 1.0 0 -16777216 true "" "plot [oa] of turtle 375"
"pen-77" 1.0 0 -2674135 true "" "plot [ob] of turtle 375"
"pen-78" 1.0 0 -16777216 true "" "plot [oa] of turtle 377"
"pen-79" 1.0 0 -2674135 true "" "plot [ob] of turtle 377"
"pen-80" 1.0 0 -16777216 true "" "plot [oa] of turtle 379"
"pen-81" 1.0 0 -2674135 true "" "plot [ob] of turtle 379"
"pen-82" 1.0 0 -16777216 true "" "plot [oa] of turtle 381"
"pen-83" 1.0 0 -2674135 true "" "plot [ob] of turtle 381"
"pen-84" 1.0 0 -16777216 true "" "plot [oa] of turtle 383"
"pen-85" 1.0 0 -2674135 true "" "plot [ob] of turtle 383"
"pen-86" 1.0 0 -16777216 true "" "plot [oa] of turtle 385"
"pen-87" 1.0 0 -2674135 true "" "plot [ob] of turtle 385"
"pen-88" 1.0 0 -16777216 true "" "plot [oa] of turtle 387"
"pen-89" 1.0 0 -2674135 true "" "plot [ob] of turtle 387"
"pen-90" 1.0 0 -16777216 true "" "plot [oa] of turtle 389"
"pen-91" 1.0 0 -2674135 true "" "plot [ob] of turtle 389"
"pen-92" 1.0 0 -16777216 true "" "plot [oa] of turtle 391"
"pen-93" 1.0 0 -2674135 true "" "plot [ob] of turtle 391"
"pen-94" 1.0 0 -16777216 true "" "plot [oa] of turtle 393"
"pen-95" 1.0 0 -2674135 true "" "plot [ob] of turtle 393"
"pen-96" 1.0 0 -16777216 true "" "plot [oa] of turtle 395"
"pen-97" 1.0 0 -2674135 true "" "plot [ob] of turtle 395"
"pen-98" 1.0 0 -16777216 true "" "plot [oa] of turtle 397"
"pen-99" 1.0 0 -2674135 true "" "plot [ob] of turtle 397"
"pen-100" 1.0 0 -16777216 true "" "plot [oa] of turtle 399"
"pen-101" 1.0 0 -2674135 true "" "plot [ob] of turtle 399"
"pen-102" 1.0 0 -16777216 true "" "plot [oa] of turtle 600"
"pen-103" 1.0 0 -2674135 true "" "plot [ob] of turtle 600"
"pen-104" 1.0 0 -16777216 true "" "plot [oa] of turtle 602"
"pen-105" 1.0 0 -2674135 true "" "plot [ob] of turtle 602"
"pen-106" 1.0 0 -16777216 true "" "plot [oa] of turtle 604"
"pen-107" 1.0 0 -2674135 true "" "plot [ob] of turtle 604"
"pen-108" 1.0 0 -16777216 true "" "plot [oa] of turtle 606"
"pen-109" 1.0 0 -2674135 true "" "plot [ob] of turtle 606"
"pen-110" 1.0 0 -16777216 true "" "plot [oa] of turtle 608"
"pen-111" 1.0 0 -2674135 true "" "plot [ob] of turtle 608"
"pen-112" 1.0 0 -16777216 true "" "plot [oa] of turtle 610"
"pen-113" 1.0 0 -2674135 true "" "plot [ob] of turtle 610"
"pen-114" 1.0 0 -16777216 true "" "plot [oa] of turtle 612"
"pen-115" 1.0 0 -2674135 true "" "plot [ob] of turtle 612"
"pen-116" 1.0 0 -16777216 true "" "plot [oa] of turtle 614"
"pen-117" 1.0 0 -2674135 true "" "plot [ob] of turtle 614"
"pen-118" 1.0 0 -16777216 true "" "plot [oa] of turtle 616"
"pen-119" 1.0 0 -2674135 true "" "plot [ob] of turtle 616"
"pen-120" 1.0 0 -16777216 true "" "plot [oa] of turtle 618"
"pen-121" 1.0 0 -2674135 true "" "plot [ob] of turtle 618"
"pen-122" 1.0 0 -16777216 true "" "plot [oa] of turtle 620"
"pen-123" 1.0 0 -2674135 true "" "plot [ob] of turtle 620"
"pen-124" 1.0 0 -16777216 true "" "plot [oa] of turtle 622"
"pen-125" 1.0 0 -2674135 true "" "plot [ob] of turtle 622"
"pen-126" 1.0 0 -16777216 true "" "plot [oa] of turtle 624"
"pen-127" 1.0 0 -2674135 true "" "plot [ob] of turtle 624"
"pen-128" 1.0 0 -16777216 true "" "plot [oa] of turtle 626"
"pen-129" 1.0 0 -2674135 true "" "plot [ob] of turtle 626"
"pen-130" 1.0 0 -16777216 true "" "plot [oa] of turtle 628"
"pen-131" 1.0 0 -2674135 true "" "plot [ob] of turtle 628"
"pen-132" 1.0 0 -16777216 true "" "plot [oa] of turtle 630"
"pen-133" 1.0 0 -2674135 true "" "plot [ob] of turtle 630"
"pen-134" 1.0 0 -16777216 true "" "plot [oa] of turtle 632"
"pen-135" 1.0 0 -2674135 true "" "plot [ob] of turtle 632"
"pen-136" 1.0 0 -16777216 true "" "plot [oa] of turtle 634"
"pen-137" 1.0 0 -2674135 true "" "plot [ob] of turtle 634"
"pen-138" 1.0 0 -16777216 true "" "plot [oa] of turtle 636"
"pen-139" 1.0 0 -2674135 true "" "plot [ob] of turtle 636"
"pen-140" 1.0 0 -16777216 true "" "plot [oa] of turtle 638"
"pen-141" 1.0 0 -2674135 true "" "plot [ob] of turtle 638"
"pen-142" 1.0 0 -16777216 true "" "plot [oa] of turtle 640"
"pen-143" 1.0 0 -2674135 true "" "plot [ob] of turtle 640"
"pen-144" 1.0 0 -16777216 true "" "plot [oa] of turtle 642"
"pen-145" 1.0 0 -2674135 true "" "plot [ob] of turtle 642"
"pen-146" 1.0 0 -16777216 true "" "plot [oa] of turtle 644"
"pen-147" 1.0 0 -2674135 true "" "plot [ob] of turtle 644"
"pen-148" 1.0 0 -16777216 true "" "plot [oa] of turtle 646"
"pen-149" 1.0 0 -2674135 true "" "plot [ob] of turtle 646"
"pen-150" 1.0 0 -16777216 true "" "plot [oa] of turtle 648"
"pen-151" 1.0 0 -2674135 true "" "plot [ob] of turtle 648"
"pen-152" 1.0 0 -16777216 true "" "plot [oa] of turtle 650"
"pen-153" 1.0 0 -2674135 true "" "plot [ob] of turtle 650"
"pen-154" 1.0 0 -16777216 true "" "plot [oa] of turtle 652"
"pen-155" 1.0 0 -2674135 true "" "plot [ob] of turtle 652"
"pen-156" 1.0 0 -16777216 true "" "plot [oa] of turtle 654"
"pen-157" 1.0 0 -2674135 true "" "plot [ob] of turtle 654"
"pen-158" 1.0 0 -16777216 true "" "plot [oa] of turtle 656"
"pen-159" 1.0 0 -2674135 true "" "plot [ob] of turtle 656"
"pen-160" 1.0 0 -16777216 true "" "plot [oa] of turtle 658"
"pen-161" 1.0 0 -2674135 true "" "plot [ob] of turtle 658"
"pen-162" 1.0 0 -16777216 true "" "plot [oa] of turtle 660"
"pen-163" 1.0 0 -2674135 true "" "plot [ob] of turtle 660"
"pen-164" 1.0 0 -16777216 true "" "plot [oa] of turtle 961"
"pen-165" 1.0 0 -2674135 true "" "plot [ob] of turtle 961"
"pen-166" 1.0 0 -16777216 true "" "plot [oa] of turtle 963"
"pen-167" 1.0 0 -2674135 true "" "plot [ob] of turtle 963"
"pen-168" 1.0 0 -16777216 true "" "plot [oa] of turtle 965"
"pen-169" 1.0 0 -2674135 true "" "plot [ob] of turtle 965"
"pen-170" 1.0 0 -16777216 true "" "plot [oa] of turtle 967"
"pen-171" 1.0 0 -2674135 true "" "plot [ob] of turtle 967"
"pen-172" 1.0 0 -16777216 true "" "plot [oa] of turtle 969"
"pen-173" 1.0 0 -2674135 true "" "plot [ob] of turtle 969"
"pen-174" 1.0 0 -16777216 true "" "plot [oa] of turtle 971"
"pen-175" 1.0 0 -2674135 true "" "plot [ob] of turtle 971"
"pen-176" 1.0 0 -16777216 true "" "plot [oa] of turtle 973"
"pen-177" 1.0 0 -2674135 true "" "plot [ob] of turtle 973"
"pen-178" 1.0 0 -16777216 true "" "plot [oa] of turtle 975"
"pen-179" 1.0 0 -2674135 true "" "plot [ob] of turtle 975"
"pen-180" 1.0 0 -16777216 true "" "plot [oa] of turtle 977"
"pen-181" 1.0 0 -2674135 true "" "plot [ob] of turtle 977"
"pen-182" 1.0 0 -2674135 true "" "plot [ob] of turtle 980"
"pen-183" 1.0 0 -16777216 true "" "plot [oa] of turtle 980"
"pen-184" 1.0 0 -16777216 true "" "plot [oa] of turtle 981"
"pen-185" 1.0 0 -2674135 true "" "plot [ob] of turtle 981"
"pen-186" 1.0 0 -16777216 true "" "plot [oa] of turtle 983"
"pen-187" 1.0 0 -2674135 true "" "plot [ob] of turtle 983"
"pen-188" 1.0 0 -16777216 true "" "plot [oa] of turtle 985"
"pen-189" 1.0 0 -2674135 true "" "plot [ob] of turtle 985"
"pen-190" 1.0 0 -16777216 true "" "plot [oa] of turtle 987"
"pen-191" 1.0 0 -2674135 true "" "plot [ob] of turtle 987"
"pen-192" 1.0 0 -16777216 true "" "plot [oa] of turtle 989"
"pen-193" 1.0 0 -2674135 true "" "plot [ob] of turtle 989"
"pen-194" 1.0 0 -16777216 true "" "plot [oa] of turtle 1130"
"pen-195" 1.0 0 -2674135 true "" "plot [ob] of turtle 1130"
"pen-196" 1.0 0 -16777216 true "" "plot [oa] of turtle 1133"
"pen-197" 1.0 0 -2674135 true "" "plot [ob] of turtle 1133"
"pen-198" 1.0 0 -16777216 true "" "plot [oa] of turtle 1137"
"pen-199" 1.0 0 -2674135 true "" "plot [ob] of turtle 1137"
"pen-200" 1.0 0 -16777216 true "" "plot [oa] of turtle 1140"

MONITOR
97
243
310
288
NIL
count turtles with [oa > 0.8]
17
1
11

MONITOR
11
340
217
385
NIL
(sum [oa] of turtles) / 1250
17
1
11

SLIDER
15
386
187
419
jjfzsl
jjfzsl
0
20
10.0
1
1
NIL
HORIZONTAL

SLIDER
10
429
182
462
uu
uu
0
1
1.0
0.1
1
NIL
HORIZONTAL

BUTTON
191
390
257
423
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

PLOT
855
229
1183
520
NIL
time
Number of radicalizatist
0.0
1000.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot count turtles with [oa > 0.8]"
"pen-1" 1.0 0 -5298144 true "" "plot count turtles with [ob > 0.8]"

SLIDER
355
96
527
129
gxyz
gxyz
0.5
1
0.75
0.05
1
NIL
HORIZONTAL

PLOT
1001
13
1198
204
NIL
NIL
mean belief value
0.0
1000.0
0.0
1.0
false
false
"" ""
PENS
"mean belief value" 1.0 0 -16777216 true "" "plot sum [oa] of turtles / 1250"
"pen-1" 1.0 0 -3844592 true "" "plot sum [ob] of turtles / 1250"

PLOT
1179
232
1493
522
NIL
NIL
polarity of belief
0.0
1000.0
0.0
0.5
false
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot standard-deviation [oa] of turtles"
"pen-1" 1.0 0 -3844592 true "" "plot standard-deviation [ob] of turtles"

BUTTON
189
431
252
464
save
save-file
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
221
340
427
385
NIL
(sum [ob] of turtles) / 1250
17
1
11

MONITOR
173
291
386
336
NIL
count turtles with [ob > 0.8]
17
1
11

MONITOR
265
386
534
431
NIL
count turtles with [oa > 0.8 and ob > 0.8]
17
1
11

PLOT
828
206
1028
356
NIL
opinion
NUM
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" ""
"pen-1" 1.0 0 -7500403 true "" ""

MONITOR
777
411
997
456
NIL
count turtles with [ oa < 0.1]
17
1
11

MONITOR
776
368
1093
413
NIL
count turtles with [ oa < 0.2 and oa >= 0.1]
17
1
11

MONITOR
776
321
1093
366
NIL
count turtles with [ oa < 0.3 and oa >= 0.2]
17
1
11

MONITOR
775
277
1092
322
NIL
count turtles with [ oa < 0.4 and oa >= 0.3]
17
1
11

MONITOR
771
230
1088
275
NIL
count turtles with [ oa < 0.5 and oa >= 0.4]
17
1
11

MONITOR
769
189
1086
234
NIL
count turtles with [ oa < 0.6 and oa >= 0.5]
17
1
11

MONITOR
765
144
1082
189
NIL
count turtles with [ oa < 0.7 and oa >= 0.6]
17
1
11

MONITOR
766
102
1083
147
NIL
count turtles with [ oa < 0.8 and oa >= 0.7]
17
1
11

MONITOR
766
57
1083
102
NIL
count turtles with [ oa < 0.9 and oa >= 0.8]
17
1
11

MONITOR
777
10
1080
55
NIL
count turtles with [ oa < 1 and oa >= 0.9]
17
1
11

MONITOR
1087
10
1307
55
NIL
count turtles with [ ob < 0.1]
17
1
11

MONITOR
1094
52
1411
97
NIL
count turtles with [ ob < 0.2 and ob >= 0.1]
17
1
11

MONITOR
1097
97
1414
142
NIL
count turtles with [ ob < 0.3 and ob >= 0.2]
17
1
11

MONITOR
1097
143
1414
188
NIL
count turtles with [ ob < 0.4 and ob >= 0.3]
17
1
11

MONITOR
1097
188
1414
233
NIL
count turtles with [ ob < 0.5 and ob >= 0.4]
17
1
11

MONITOR
1096
234
1413
279
NIL
count turtles with [ ob < 0.6 and ob >= 0.5]
17
1
11

MONITOR
1093
280
1410
325
NIL
count turtles with [ ob < 0.7 and ob >= 0.6]
17
1
11

MONITOR
1098
322
1415
367
NIL
count turtles with [ ob < 0.8 and ob >= 0.7]
17
1
11

MONITOR
1096
368
1413
413
NIL
count turtles with [ ob < 0.9 and ob >= 0.8]
17
1
11

MONITOR
1094
412
1397
457
NIL
count turtles with [ ob < 1 and ob >= 0.9]
17
1
11

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.3.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
<experiments>
  <experiment name="jjfzsl suiji" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="20"/>
    <metric>count turtles with [ o &gt; 0.8]</metric>
    <metric>sum [o] of turtles / 1250</metric>
    <enumeratedValueSet variable="g">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="s">
      <value value="0.8"/>
    </enumeratedValueSet>
    <steppedValueSet variable="jjfzsl" first="0" step="125" last="1000"/>
    <enumeratedValueSet variable="layout?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="l">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="plot?">
      <value value="true"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="jjfz-fone" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="20"/>
    <metric>count turtles with [ o &gt; 0.8]</metric>
    <metric>sum [o] of turtles / 1250</metric>
    <enumeratedValueSet variable="g">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="s">
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="jjfzsl">
      <value value="125"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="layout?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="l">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="plot?">
      <value value="true"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="jjfz-ftwo" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="20"/>
    <metric>count turtles with [ o &gt; 0.8]</metric>
    <metric>sum [o] of turtles / 1250</metric>
    <enumeratedValueSet variable="g">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="s">
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="jjfzsl">
      <value value="125"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="layout?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="l">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="plot?">
      <value value="true"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="jjfz-fthree" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="20"/>
    <metric>count turtles with [ o &gt; 0.8]</metric>
    <metric>sum [o] of turtles / 1250</metric>
    <enumeratedValueSet variable="g">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="s">
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="jjfzsl">
      <value value="125"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="layout?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="l">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="plot?">
      <value value="true"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="jjfz-ffour" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="20"/>
    <metric>count turtles with [ o &gt; 0.8]</metric>
    <metric>sum [o] of turtles / 1250</metric>
    <enumeratedValueSet variable="g">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="s">
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="jjfzsl">
      <value value="125"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="layout?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="l">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="plot?">
      <value value="true"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="jjfz-ffive" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="20"/>
    <metric>count turtles with [ o &gt; 0.8]</metric>
    <metric>sum [o] of turtles / 1250</metric>
    <enumeratedValueSet variable="g">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="s">
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="jjfzsl">
      <value value="63"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="layout?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="l">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="plot?">
      <value value="true"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="jjfzsl twothree" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="20"/>
    <metric>count turtles with [ o &gt; 0.8]</metric>
    <metric>sum [o] of turtles / 1250</metric>
    <enumeratedValueSet variable="g">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="s">
      <value value="0.8"/>
    </enumeratedValueSet>
    <steppedValueSet variable="jjfzsl" first="125" step="125" last="500"/>
    <enumeratedValueSet variable="layout?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="l">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="plot?">
      <value value="true"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="jianchidu" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="100"/>
    <metric>count turtles with [ o &gt; 0.8]</metric>
    <metric>sum [o] of turtles / 1250</metric>
    <enumeratedValueSet variable="g">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="s">
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="jjfzsl">
      <value value="125"/>
    </enumeratedValueSet>
    <steppedValueSet variable="uu" first="0.1" step="0.1" last="1"/>
    <enumeratedValueSet variable="layout?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="l">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="plot?">
      <value value="true"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="xinrenyuzhi" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="100"/>
    <metric>count turtles with [ o &gt; 0.8]</metric>
    <metric>sum [o] of turtles / 1250</metric>
    <enumeratedValueSet variable="g">
      <value value="0.5"/>
    </enumeratedValueSet>
    <steppedValueSet variable="s" first="0.7" step="0.1" last="1"/>
    <enumeratedValueSet variable="jjfzsl">
      <value value="125"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="uu">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="layout?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="l">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="plot?">
      <value value="true"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="kehuodexing" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="100"/>
    <metric>count turtles with [ o &gt; 0.8]</metric>
    <metric>sum [o] of turtles / 1250</metric>
    <enumeratedValueSet variable="g">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="s">
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="jjfzsl">
      <value value="125"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="uu">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="layout?">
      <value value="false"/>
    </enumeratedValueSet>
    <steppedValueSet variable="l" first="0" step="0.1" last="1"/>
    <enumeratedValueSet variable="plot?">
      <value value="true"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="experiment" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <metric>count turtles</metric>
    <enumeratedValueSet variable="gxyz">
      <value value="0.65"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="g">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="s">
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="uu">
      <value value="0.9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="jjfzsl">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="layout?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="l">
      <value value="4.0E-4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="plot?">
      <value value="true"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="0.65,0.75" repetitions="5" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="1000"/>
    <metric>count turtles with [ o &gt; 0.8]</metric>
    <enumeratedValueSet variable="gxyz">
      <value value="0.65"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="g">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="s">
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="uu">
      <value value="0.9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="jjfzsl">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="layout?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="l">
      <value value="4.0E-4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="plot?">
      <value value="true"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="0.7,0.75" repetitions="5" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="1000"/>
    <metric>count turtles with [ o &gt; 0.8]</metric>
    <enumeratedValueSet variable="gxyz">
      <value value="0.7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="g">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="s">
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="uu">
      <value value="0.9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="jjfzsl">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="layout?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="l">
      <value value="4.0E-4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="plot?">
      <value value="true"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="0.75,0.75" repetitions="5" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="1000"/>
    <metric>count turtles with [ o &gt; 0.8]</metric>
    <enumeratedValueSet variable="gxyz">
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="g">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="s">
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="uu">
      <value value="0.9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="jjfzsl">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="layout?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="l">
      <value value="4.0E-4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="plot?">
      <value value="true"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="0.6,0.65" repetitions="5" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="1000"/>
    <metric>count turtles with [ o &gt; 0.8]</metric>
    <enumeratedValueSet variable="gxyz">
      <value value="0.6"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="g">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="s">
      <value value="0.65"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="uu">
      <value value="0.9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="jjfzsl">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="layout?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="l">
      <value value="4.0E-4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="plot?">
      <value value="true"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="0.6,0.7" repetitions="5" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="1000"/>
    <metric>count turtles with [ o &gt; 0.8]</metric>
    <enumeratedValueSet variable="gxyz">
      <value value="0.6"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="g">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="s">
      <value value="0.7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="uu">
      <value value="0.9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="jjfzsl">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="layout?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="l">
      <value value="4.0E-4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="plot?">
      <value value="true"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="0.75,0.65" repetitions="5" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="1000"/>
    <metric>count turtles with [ o &gt; 0.8]</metric>
    <enumeratedValueSet variable="gxyz">
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="g">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="s">
      <value value="0.65"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="uu">
      <value value="0.9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="jjfzsl">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="layout?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="l">
      <value value="4.0E-4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="plot?">
      <value value="true"/>
    </enumeratedValueSet>
  </experiment>
</experiments>
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
