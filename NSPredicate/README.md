# NSPredicate
 iOS Predicate 即谓词逻辑。和数据库的SQL语句具有相似性，都是从数据堆中根据条件进行筛选。


使用场景：        

  （1）NSPredicate给我留下最深印象的是两个数组求交集的一个需求，如果按照一般写法，需要2个遍历，但NSArray提供了一个filterUsingPredicate的方法，用了NSPredicate，就可以不用遍历！
  
  （2）在存储自定义对象的数组中，可以根据条件查询数组中满足条件的对象。
