ATTACH DATABASE 'zanzibar.db' AS db;

create table config (namespace, rel, rewrite, relation, tupleset, computed_userset);
create table tuple (namespace, object_id, rel, user_type, user_id, user_namespace, user_object_id, user_relation);

insert into config values ("folder", "viewer", "self", "", "", "");
insert into config values ("document", "parent", "self", "", "", "");
insert into config values ("document", "viewer", "self", "", "", "");
insert into config values ("document", "viewer", "tupleToUserset", "", "parent", "viewer");

insert into tuple values ("folder", "x", "viewer", "id", "abigail", "", "", "");
insert into tuple values ("document", "1", "parent", "object", "", "folder", "x", "");
insert into tuple values ("document", "1", "viewer", "id", "beatrix", "", "", "");

-- This query generates a table with all the answers
WITH t_14_List_r0 AS (SELECT * FROM (
  
    SELECT
      t_16_Config.namespace AS namespace,
      Tuple.object_id AS object_id,
      t_16_Config.rel AS rel,
      Tuple.user_type AS user_type,
      Tuple.user_id AS user_id,
      Tuple.user_namespace AS user_namespace,
      Tuple.user_object_id AS user_object_id,
      Tuple.user_relation AS user_relation
    FROM
      Config AS t_16_Config, Tuple
    WHERE
      (t_16_Config.rewrite = 'self') AND
      (Tuple.namespace = t_16_Config.namespace) AND
      (Tuple.rel = t_16_Config.rel)
  
) AS UNUSED_TABLE_NAME  ),
t_12_List_r1 AS (SELECT * FROM (
  
    SELECT
      t_13_Config.namespace AS namespace,
      List_r0.object_id AS object_id,
      t_13_Config.rel AS rel,
      List_r0.user_type AS user_type,
      List_r0.user_id AS user_id,
      List_r0.user_namespace AS user_namespace,
      List_r0.user_object_id AS user_object_id,
      List_r0.user_relation AS user_relation
    FROM
      Config AS t_13_Config, t_14_List_r0 AS List_r0
    WHERE
      (t_13_Config.rewrite = 'computedUserset') AND
      (List_r0.namespace = t_13_Config.namespace) AND
      (List_r0.rel = t_13_Config.relation)
   UNION ALL
  
    SELECT
      t_23_Config.namespace AS namespace,
      t_24_Tuple.object_id AS object_id,
      t_23_Config.rel AS rel,
      t_24_Tuple.user_type AS user_type,
      t_24_Tuple.user_id AS user_id,
      t_24_Tuple.user_namespace AS user_namespace,
      t_24_Tuple.user_object_id AS user_object_id,
      t_24_Tuple.user_relation AS user_relation
    FROM
      Config AS t_23_Config, Tuple AS t_24_Tuple
    WHERE
      (t_23_Config.rewrite = 'self') AND
      (t_24_Tuple.namespace = t_23_Config.namespace) AND
      (t_24_Tuple.rel = t_23_Config.rel)
   UNION ALL
  
    SELECT
      t_25_Config.namespace AS namespace,
      t_26_Tuple.object_id AS object_id,
      t_25_Config.rel AS rel,
      t_27_List_r0.user_type AS user_type,
      t_27_List_r0.user_id AS user_id,
      t_27_List_r0.user_namespace AS user_namespace,
      t_27_List_r0.user_object_id AS user_object_id,
      t_26_Tuple.user_relation AS user_relation
    FROM
      Config AS t_25_Config, Tuple AS t_26_Tuple, t_14_List_r0 AS t_27_List_r0
    WHERE
      (t_25_Config.rewrite = 'tupleToUserset') AND
      (t_26_Tuple.namespace = t_25_Config.namespace) AND
      (t_26_Tuple.rel = t_25_Config.tupleset) AND
      (t_26_Tuple.user_type = 'object') AND
      (t_27_List_r0.namespace = t_26_Tuple.user_namespace) AND
      (t_27_List_r0.object_id = t_26_Tuple.user_object_id) AND
      (t_27_List_r0.rel = t_25_Config.computed_userset) AND
      (t_27_List_r0.user_relation = t_26_Tuple.user_relation)
   UNION ALL
  
    SELECT
      t_38_Config.namespace AS namespace,
      t_39_Tuple.object_id AS object_id,
      t_38_Config.rel AS rel,
      t_40_List_r0.user_type AS user_type,
      t_40_List_r0.user_id AS user_id,
      t_40_List_r0.user_namespace AS user_namespace,
      t_40_List_r0.user_object_id AS user_object_id,
      t_40_List_r0.user_relation AS user_relation
    FROM
      Config AS t_38_Config, Tuple AS t_39_Tuple, t_14_List_r0 AS t_40_List_r0
    WHERE
      (t_38_Config.rewrite = 'tupleToUserset') AND
      (t_39_Tuple.namespace = t_38_Config.namespace) AND
      (t_39_Tuple.rel = t_38_Config.tupleset) AND
      (t_39_Tuple.user_type = 'userset') AND
      (t_39_Tuple.user_relation = t_38_Config.computed_userset) AND
      (t_40_List_r0.namespace = t_39_Tuple.user_namespace) AND
      (t_40_List_r0.object_id = t_39_Tuple.user_object_id) AND
      (t_40_List_r0.rel = t_38_Config.computed_userset)
  
) AS UNUSED_TABLE_NAME  ),
t_10_List_r2 AS (SELECT * FROM (
  
    SELECT
      t_11_Config.namespace AS namespace,
      List_r1.object_id AS object_id,
      t_11_Config.rel AS rel,
      List_r1.user_type AS user_type,
      List_r1.user_id AS user_id,
      List_r1.user_namespace AS user_namespace,
      List_r1.user_object_id AS user_object_id,
      List_r1.user_relation AS user_relation
    FROM
      Config AS t_11_Config, t_12_List_r1 AS List_r1
    WHERE
      (t_11_Config.rewrite = 'computedUserset') AND
      (List_r1.namespace = t_11_Config.namespace) AND
      (List_r1.rel = t_11_Config.relation)
   UNION ALL
  
    SELECT
      t_41_Config.namespace AS namespace,
      t_42_Tuple.object_id AS object_id,
      t_41_Config.rel AS rel,
      t_42_Tuple.user_type AS user_type,
      t_42_Tuple.user_id AS user_id,
      t_42_Tuple.user_namespace AS user_namespace,
      t_42_Tuple.user_object_id AS user_object_id,
      t_42_Tuple.user_relation AS user_relation
    FROM
      Config AS t_41_Config, Tuple AS t_42_Tuple
    WHERE
      (t_41_Config.rewrite = 'self') AND
      (t_42_Tuple.namespace = t_41_Config.namespace) AND
      (t_42_Tuple.rel = t_41_Config.rel)
   UNION ALL
  
    SELECT
      t_43_Config.namespace AS namespace,
      t_44_Tuple.object_id AS object_id,
      t_43_Config.rel AS rel,
      t_45_List_r1.user_type AS user_type,
      t_45_List_r1.user_id AS user_id,
      t_45_List_r1.user_namespace AS user_namespace,
      t_45_List_r1.user_object_id AS user_object_id,
      t_44_Tuple.user_relation AS user_relation
    FROM
      Config AS t_43_Config, Tuple AS t_44_Tuple, t_12_List_r1 AS t_45_List_r1
    WHERE
      (t_43_Config.rewrite = 'tupleToUserset') AND
      (t_44_Tuple.namespace = t_43_Config.namespace) AND
      (t_44_Tuple.rel = t_43_Config.tupleset) AND
      (t_44_Tuple.user_type = 'object') AND
      (t_45_List_r1.namespace = t_44_Tuple.user_namespace) AND
      (t_45_List_r1.object_id = t_44_Tuple.user_object_id) AND
      (t_45_List_r1.rel = t_43_Config.computed_userset) AND
      (t_45_List_r1.user_relation = t_44_Tuple.user_relation)
   UNION ALL
  
    SELECT
      t_56_Config.namespace AS namespace,
      t_57_Tuple.object_id AS object_id,
      t_56_Config.rel AS rel,
      t_58_List_r1.user_type AS user_type,
      t_58_List_r1.user_id AS user_id,
      t_58_List_r1.user_namespace AS user_namespace,
      t_58_List_r1.user_object_id AS user_object_id,
      t_58_List_r1.user_relation AS user_relation
    FROM
      Config AS t_56_Config, Tuple AS t_57_Tuple, t_12_List_r1 AS t_58_List_r1
    WHERE
      (t_56_Config.rewrite = 'tupleToUserset') AND
      (t_57_Tuple.namespace = t_56_Config.namespace) AND
      (t_57_Tuple.rel = t_56_Config.tupleset) AND
      (t_57_Tuple.user_type = 'userset') AND
      (t_57_Tuple.user_relation = t_56_Config.computed_userset) AND
      (t_58_List_r1.namespace = t_57_Tuple.user_namespace) AND
      (t_58_List_r1.object_id = t_57_Tuple.user_object_id) AND
      (t_58_List_r1.rel = t_56_Config.computed_userset)
  
) AS UNUSED_TABLE_NAME  ),
t_8_List_r3 AS (SELECT * FROM (
  
    SELECT
      t_9_Config.namespace AS namespace,
      List_r2.object_id AS object_id,
      t_9_Config.rel AS rel,
      List_r2.user_type AS user_type,
      List_r2.user_id AS user_id,
      List_r2.user_namespace AS user_namespace,
      List_r2.user_object_id AS user_object_id,
      List_r2.user_relation AS user_relation
    FROM
      Config AS t_9_Config, t_10_List_r2 AS List_r2
    WHERE
      (t_9_Config.rewrite = 'computedUserset') AND
      (List_r2.namespace = t_9_Config.namespace) AND
      (List_r2.rel = t_9_Config.relation)
   UNION ALL
  
    SELECT
      t_59_Config.namespace AS namespace,
      t_60_Tuple.object_id AS object_id,
      t_59_Config.rel AS rel,
      t_60_Tuple.user_type AS user_type,
      t_60_Tuple.user_id AS user_id,
      t_60_Tuple.user_namespace AS user_namespace,
      t_60_Tuple.user_object_id AS user_object_id,
      t_60_Tuple.user_relation AS user_relation
    FROM
      Config AS t_59_Config, Tuple AS t_60_Tuple
    WHERE
      (t_59_Config.rewrite = 'self') AND
      (t_60_Tuple.namespace = t_59_Config.namespace) AND
      (t_60_Tuple.rel = t_59_Config.rel)
   UNION ALL
  
    SELECT
      t_61_Config.namespace AS namespace,
      t_62_Tuple.object_id AS object_id,
      t_61_Config.rel AS rel,
      t_63_List_r2.user_type AS user_type,
      t_63_List_r2.user_id AS user_id,
      t_63_List_r2.user_namespace AS user_namespace,
      t_63_List_r2.user_object_id AS user_object_id,
      t_62_Tuple.user_relation AS user_relation
    FROM
      Config AS t_61_Config, Tuple AS t_62_Tuple, t_10_List_r2 AS t_63_List_r2
    WHERE
      (t_61_Config.rewrite = 'tupleToUserset') AND
      (t_62_Tuple.namespace = t_61_Config.namespace) AND
      (t_62_Tuple.rel = t_61_Config.tupleset) AND
      (t_62_Tuple.user_type = 'object') AND
      (t_63_List_r2.namespace = t_62_Tuple.user_namespace) AND
      (t_63_List_r2.object_id = t_62_Tuple.user_object_id) AND
      (t_63_List_r2.rel = t_61_Config.computed_userset) AND
      (t_63_List_r2.user_relation = t_62_Tuple.user_relation)
   UNION ALL
  
    SELECT
      t_74_Config.namespace AS namespace,
      t_75_Tuple.object_id AS object_id,
      t_74_Config.rel AS rel,
      t_76_List_r2.user_type AS user_type,
      t_76_List_r2.user_id AS user_id,
      t_76_List_r2.user_namespace AS user_namespace,
      t_76_List_r2.user_object_id AS user_object_id,
      t_76_List_r2.user_relation AS user_relation
    FROM
      Config AS t_74_Config, Tuple AS t_75_Tuple, t_10_List_r2 AS t_76_List_r2
    WHERE
      (t_74_Config.rewrite = 'tupleToUserset') AND
      (t_75_Tuple.namespace = t_74_Config.namespace) AND
      (t_75_Tuple.rel = t_74_Config.tupleset) AND
      (t_75_Tuple.user_type = 'userset') AND
      (t_75_Tuple.user_relation = t_74_Config.computed_userset) AND
      (t_76_List_r2.namespace = t_75_Tuple.user_namespace) AND
      (t_76_List_r2.object_id = t_75_Tuple.user_object_id) AND
      (t_76_List_r2.rel = t_74_Config.computed_userset)
  
) AS UNUSED_TABLE_NAME  ),
t_6_List_r4 AS (SELECT * FROM (
  
    SELECT
      t_7_Config.namespace AS namespace,
      List_r3.object_id AS object_id,
      t_7_Config.rel AS rel,
      List_r3.user_type AS user_type,
      List_r3.user_id AS user_id,
      List_r3.user_namespace AS user_namespace,
      List_r3.user_object_id AS user_object_id,
      List_r3.user_relation AS user_relation
    FROM
      Config AS t_7_Config, t_8_List_r3 AS List_r3
    WHERE
      (t_7_Config.rewrite = 'computedUserset') AND
      (List_r3.namespace = t_7_Config.namespace) AND
      (List_r3.rel = t_7_Config.relation)
   UNION ALL
  
    SELECT
      t_77_Config.namespace AS namespace,
      t_78_Tuple.object_id AS object_id,
      t_77_Config.rel AS rel,
      t_78_Tuple.user_type AS user_type,
      t_78_Tuple.user_id AS user_id,
      t_78_Tuple.user_namespace AS user_namespace,
      t_78_Tuple.user_object_id AS user_object_id,
      t_78_Tuple.user_relation AS user_relation
    FROM
      Config AS t_77_Config, Tuple AS t_78_Tuple
    WHERE
      (t_77_Config.rewrite = 'self') AND
      (t_78_Tuple.namespace = t_77_Config.namespace) AND
      (t_78_Tuple.rel = t_77_Config.rel)
   UNION ALL
  
    SELECT
      t_79_Config.namespace AS namespace,
      t_80_Tuple.object_id AS object_id,
      t_79_Config.rel AS rel,
      t_81_List_r3.user_type AS user_type,
      t_81_List_r3.user_id AS user_id,
      t_81_List_r3.user_namespace AS user_namespace,
      t_81_List_r3.user_object_id AS user_object_id,
      t_80_Tuple.user_relation AS user_relation
    FROM
      Config AS t_79_Config, Tuple AS t_80_Tuple, t_8_List_r3 AS t_81_List_r3
    WHERE
      (t_79_Config.rewrite = 'tupleToUserset') AND
      (t_80_Tuple.namespace = t_79_Config.namespace) AND
      (t_80_Tuple.rel = t_79_Config.tupleset) AND
      (t_80_Tuple.user_type = 'object') AND
      (t_81_List_r3.namespace = t_80_Tuple.user_namespace) AND
      (t_81_List_r3.object_id = t_80_Tuple.user_object_id) AND
      (t_81_List_r3.rel = t_79_Config.computed_userset) AND
      (t_81_List_r3.user_relation = t_80_Tuple.user_relation)
   UNION ALL
  
    SELECT
      t_92_Config.namespace AS namespace,
      t_93_Tuple.object_id AS object_id,
      t_92_Config.rel AS rel,
      t_94_List_r3.user_type AS user_type,
      t_94_List_r3.user_id AS user_id,
      t_94_List_r3.user_namespace AS user_namespace,
      t_94_List_r3.user_object_id AS user_object_id,
      t_94_List_r3.user_relation AS user_relation
    FROM
      Config AS t_92_Config, Tuple AS t_93_Tuple, t_8_List_r3 AS t_94_List_r3
    WHERE
      (t_92_Config.rewrite = 'tupleToUserset') AND
      (t_93_Tuple.namespace = t_92_Config.namespace) AND
      (t_93_Tuple.rel = t_92_Config.tupleset) AND
      (t_93_Tuple.user_type = 'userset') AND
      (t_93_Tuple.user_relation = t_92_Config.computed_userset) AND
      (t_94_List_r3.namespace = t_93_Tuple.user_namespace) AND
      (t_94_List_r3.object_id = t_93_Tuple.user_object_id) AND
      (t_94_List_r3.rel = t_92_Config.computed_userset)
  
) AS UNUSED_TABLE_NAME  ),
t_4_List_r5 AS (SELECT * FROM (
  
    SELECT
      t_5_Config.namespace AS namespace,
      List_r4.object_id AS object_id,
      t_5_Config.rel AS rel,
      List_r4.user_type AS user_type,
      List_r4.user_id AS user_id,
      List_r4.user_namespace AS user_namespace,
      List_r4.user_object_id AS user_object_id,
      List_r4.user_relation AS user_relation
    FROM
      Config AS t_5_Config, t_6_List_r4 AS List_r4
    WHERE
      (t_5_Config.rewrite = 'computedUserset') AND
      (List_r4.namespace = t_5_Config.namespace) AND
      (List_r4.rel = t_5_Config.relation)
   UNION ALL
  
    SELECT
      t_95_Config.namespace AS namespace,
      t_96_Tuple.object_id AS object_id,
      t_95_Config.rel AS rel,
      t_96_Tuple.user_type AS user_type,
      t_96_Tuple.user_id AS user_id,
      t_96_Tuple.user_namespace AS user_namespace,
      t_96_Tuple.user_object_id AS user_object_id,
      t_96_Tuple.user_relation AS user_relation
    FROM
      Config AS t_95_Config, Tuple AS t_96_Tuple
    WHERE
      (t_95_Config.rewrite = 'self') AND
      (t_96_Tuple.namespace = t_95_Config.namespace) AND
      (t_96_Tuple.rel = t_95_Config.rel)
   UNION ALL
  
    SELECT
      t_97_Config.namespace AS namespace,
      t_98_Tuple.object_id AS object_id,
      t_97_Config.rel AS rel,
      t_99_List_r4.user_type AS user_type,
      t_99_List_r4.user_id AS user_id,
      t_99_List_r4.user_namespace AS user_namespace,
      t_99_List_r4.user_object_id AS user_object_id,
      t_98_Tuple.user_relation AS user_relation
    FROM
      Config AS t_97_Config, Tuple AS t_98_Tuple, t_6_List_r4 AS t_99_List_r4
    WHERE
      (t_97_Config.rewrite = 'tupleToUserset') AND
      (t_98_Tuple.namespace = t_97_Config.namespace) AND
      (t_98_Tuple.rel = t_97_Config.tupleset) AND
      (t_98_Tuple.user_type = 'object') AND
      (t_99_List_r4.namespace = t_98_Tuple.user_namespace) AND
      (t_99_List_r4.object_id = t_98_Tuple.user_object_id) AND
      (t_99_List_r4.rel = t_97_Config.computed_userset) AND
      (t_99_List_r4.user_relation = t_98_Tuple.user_relation)
   UNION ALL
  
    SELECT
      t_110_Config.namespace AS namespace,
      t_111_Tuple.object_id AS object_id,
      t_110_Config.rel AS rel,
      t_112_List_r4.user_type AS user_type,
      t_112_List_r4.user_id AS user_id,
      t_112_List_r4.user_namespace AS user_namespace,
      t_112_List_r4.user_object_id AS user_object_id,
      t_112_List_r4.user_relation AS user_relation
    FROM
      Config AS t_110_Config, Tuple AS t_111_Tuple, t_6_List_r4 AS t_112_List_r4
    WHERE
      (t_110_Config.rewrite = 'tupleToUserset') AND
      (t_111_Tuple.namespace = t_110_Config.namespace) AND
      (t_111_Tuple.rel = t_110_Config.tupleset) AND
      (t_111_Tuple.user_type = 'userset') AND
      (t_111_Tuple.user_relation = t_110_Config.computed_userset) AND
      (t_112_List_r4.namespace = t_111_Tuple.user_namespace) AND
      (t_112_List_r4.object_id = t_111_Tuple.user_object_id) AND
      (t_112_List_r4.rel = t_110_Config.computed_userset)
  
) AS UNUSED_TABLE_NAME  ),
t_2_List_r6 AS (SELECT * FROM (
  
    SELECT
      t_3_Config.namespace AS namespace,
      List_r5.object_id AS object_id,
      t_3_Config.rel AS rel,
      List_r5.user_type AS user_type,
      List_r5.user_id AS user_id,
      List_r5.user_namespace AS user_namespace,
      List_r5.user_object_id AS user_object_id,
      List_r5.user_relation AS user_relation
    FROM
      Config AS t_3_Config, t_4_List_r5 AS List_r5
    WHERE
      (t_3_Config.rewrite = 'computedUserset') AND
      (List_r5.namespace = t_3_Config.namespace) AND
      (List_r5.rel = t_3_Config.relation)
   UNION ALL
  
    SELECT
      t_113_Config.namespace AS namespace,
      t_114_Tuple.object_id AS object_id,
      t_113_Config.rel AS rel,
      t_114_Tuple.user_type AS user_type,
      t_114_Tuple.user_id AS user_id,
      t_114_Tuple.user_namespace AS user_namespace,
      t_114_Tuple.user_object_id AS user_object_id,
      t_114_Tuple.user_relation AS user_relation
    FROM
      Config AS t_113_Config, Tuple AS t_114_Tuple
    WHERE
      (t_113_Config.rewrite = 'self') AND
      (t_114_Tuple.namespace = t_113_Config.namespace) AND
      (t_114_Tuple.rel = t_113_Config.rel)
   UNION ALL
  
    SELECT
      t_115_Config.namespace AS namespace,
      t_116_Tuple.object_id AS object_id,
      t_115_Config.rel AS rel,
      t_117_List_r5.user_type AS user_type,
      t_117_List_r5.user_id AS user_id,
      t_117_List_r5.user_namespace AS user_namespace,
      t_117_List_r5.user_object_id AS user_object_id,
      t_116_Tuple.user_relation AS user_relation
    FROM
      Config AS t_115_Config, Tuple AS t_116_Tuple, t_4_List_r5 AS t_117_List_r5
    WHERE
      (t_115_Config.rewrite = 'tupleToUserset') AND
      (t_116_Tuple.namespace = t_115_Config.namespace) AND
      (t_116_Tuple.rel = t_115_Config.tupleset) AND
      (t_116_Tuple.user_type = 'object') AND
      (t_117_List_r5.namespace = t_116_Tuple.user_namespace) AND
      (t_117_List_r5.object_id = t_116_Tuple.user_object_id) AND
      (t_117_List_r5.rel = t_115_Config.computed_userset) AND
      (t_117_List_r5.user_relation = t_116_Tuple.user_relation)
   UNION ALL
  
    SELECT
      t_128_Config.namespace AS namespace,
      t_129_Tuple.object_id AS object_id,
      t_128_Config.rel AS rel,
      t_130_List_r5.user_type AS user_type,
      t_130_List_r5.user_id AS user_id,
      t_130_List_r5.user_namespace AS user_namespace,
      t_130_List_r5.user_object_id AS user_object_id,
      t_130_List_r5.user_relation AS user_relation
    FROM
      Config AS t_128_Config, Tuple AS t_129_Tuple, t_4_List_r5 AS t_130_List_r5
    WHERE
      (t_128_Config.rewrite = 'tupleToUserset') AND
      (t_129_Tuple.namespace = t_128_Config.namespace) AND
      (t_129_Tuple.rel = t_128_Config.tupleset) AND
      (t_129_Tuple.user_type = 'userset') AND
      (t_129_Tuple.user_relation = t_128_Config.computed_userset) AND
      (t_130_List_r5.namespace = t_129_Tuple.user_namespace) AND
      (t_130_List_r5.object_id = t_129_Tuple.user_object_id) AND
      (t_130_List_r5.rel = t_128_Config.computed_userset)
  
) AS UNUSED_TABLE_NAME  ),
t_0_List_r7 AS (SELECT * FROM (
  
    SELECT
      t_1_Config.namespace AS namespace,
      List_r6.object_id AS object_id,
      t_1_Config.rel AS rel,
      List_r6.user_type AS user_type,
      List_r6.user_id AS user_id,
      List_r6.user_namespace AS user_namespace,
      List_r6.user_object_id AS user_object_id,
      List_r6.user_relation AS user_relation
    FROM
      Config AS t_1_Config, t_2_List_r6 AS List_r6
    WHERE
      (t_1_Config.rewrite = 'computedUserset') AND
      (List_r6.namespace = t_1_Config.namespace) AND
      (List_r6.rel = t_1_Config.relation)
   UNION ALL
  
    SELECT
      t_131_Config.namespace AS namespace,
      t_132_Tuple.object_id AS object_id,
      t_131_Config.rel AS rel,
      t_132_Tuple.user_type AS user_type,
      t_132_Tuple.user_id AS user_id,
      t_132_Tuple.user_namespace AS user_namespace,
      t_132_Tuple.user_object_id AS user_object_id,
      t_132_Tuple.user_relation AS user_relation
    FROM
      Config AS t_131_Config, Tuple AS t_132_Tuple
    WHERE
      (t_131_Config.rewrite = 'self') AND
      (t_132_Tuple.namespace = t_131_Config.namespace) AND
      (t_132_Tuple.rel = t_131_Config.rel)
   UNION ALL
  
    SELECT
      t_133_Config.namespace AS namespace,
      t_134_Tuple.object_id AS object_id,
      t_133_Config.rel AS rel,
      t_135_List_r6.user_type AS user_type,
      t_135_List_r6.user_id AS user_id,
      t_135_List_r6.user_namespace AS user_namespace,
      t_135_List_r6.user_object_id AS user_object_id,
      t_134_Tuple.user_relation AS user_relation
    FROM
      Config AS t_133_Config, Tuple AS t_134_Tuple, t_2_List_r6 AS t_135_List_r6
    WHERE
      (t_133_Config.rewrite = 'tupleToUserset') AND
      (t_134_Tuple.namespace = t_133_Config.namespace) AND
      (t_134_Tuple.rel = t_133_Config.tupleset) AND
      (t_134_Tuple.user_type = 'object') AND
      (t_135_List_r6.namespace = t_134_Tuple.user_namespace) AND
      (t_135_List_r6.object_id = t_134_Tuple.user_object_id) AND
      (t_135_List_r6.rel = t_133_Config.computed_userset) AND
      (t_135_List_r6.user_relation = t_134_Tuple.user_relation)
   UNION ALL
  
    SELECT
      t_146_Config.namespace AS namespace,
      t_147_Tuple.object_id AS object_id,
      t_146_Config.rel AS rel,
      t_148_List_r6.user_type AS user_type,
      t_148_List_r6.user_id AS user_id,
      t_148_List_r6.user_namespace AS user_namespace,
      t_148_List_r6.user_object_id AS user_object_id,
      t_148_List_r6.user_relation AS user_relation
    FROM
      Config AS t_146_Config, Tuple AS t_147_Tuple, t_2_List_r6 AS t_148_List_r6
    WHERE
      (t_146_Config.rewrite = 'tupleToUserset') AND
      (t_147_Tuple.namespace = t_146_Config.namespace) AND
      (t_147_Tuple.rel = t_146_Config.tupleset) AND
      (t_147_Tuple.user_type = 'userset') AND
      (t_147_Tuple.user_relation = t_146_Config.computed_userset) AND
      (t_148_List_r6.namespace = t_147_Tuple.user_namespace) AND
      (t_148_List_r6.object_id = t_147_Tuple.user_object_id) AND
      (t_148_List_r6.rel = t_146_Config.computed_userset)
  
) AS UNUSED_TABLE_NAME  )
SELECT * FROM (
  
    SELECT
      Config.namespace AS namespace,
      List_r7.object_id AS object_id,
      Config.rel AS rel,
      List_r7.user_type AS user_type,
      List_r7.user_id AS user_id,
      List_r7.user_namespace AS user_namespace,
      List_r7.user_object_id AS user_object_id,
      List_r7.user_relation AS user_relation
    FROM
      Config, t_0_List_r7 AS List_r7
    WHERE
      (Config.rewrite = 'computedUserset') AND
      (List_r7.namespace = Config.namespace) AND
      (List_r7.rel = Config.relation)
   UNION ALL
  
    SELECT
      Config.namespace AS namespace,
      Tuple.object_id AS object_id,
      Config.rel AS rel,
      Tuple.user_type AS user_type,
      Tuple.user_id AS user_id,
      Tuple.user_namespace AS user_namespace,
      Tuple.user_object_id AS user_object_id,
      Tuple.user_relation AS user_relation
    FROM
      Config, Tuple
    WHERE
      (Config.rewrite = 'self') AND
      (Tuple.namespace = Config.namespace) AND
      (Tuple.rel = Config.rel)
   UNION ALL
  
    SELECT
      Config.namespace AS namespace,
      Tuple.object_id AS object_id,
      Config.rel AS rel,
      List_r7.user_type AS user_type,
      List_r7.user_id AS user_id,
      List_r7.user_namespace AS user_namespace,
      List_r7.user_object_id AS user_object_id,
      Tuple.user_relation AS user_relation
    FROM
      Config, Tuple, t_0_List_r7 AS List_r7
    WHERE
      (Config.rewrite = 'tupleToUserset') AND
      (Tuple.namespace = Config.namespace) AND
      (Tuple.rel = Config.tupleset) AND
      (Tuple.user_type = 'object') AND
      (List_r7.namespace = Tuple.user_namespace) AND
      (List_r7.object_id = Tuple.user_object_id) AND
      (List_r7.rel = Config.computed_userset) AND
      (List_r7.user_relation = Tuple.user_relation)
   UNION ALL
  
    SELECT
      Config.namespace AS namespace,
      Tuple.object_id AS object_id,
      Config.rel AS rel,
      List_r7.user_type AS user_type,
      List_r7.user_id AS user_id,
      List_r7.user_namespace AS user_namespace,
      List_r7.user_object_id AS user_object_id,
      List_r7.user_relation AS user_relation
    FROM
      Config, Tuple, t_0_List_r7 AS List_r7
    WHERE
      (Config.rewrite = 'tupleToUserset') AND
      (Tuple.namespace = Config.namespace) AND
      (Tuple.rel = Config.tupleset) AND
      (Tuple.user_type = 'userset') AND
      (Tuple.user_relation = Config.computed_userset) AND
      (List_r7.namespace = Tuple.user_namespace) AND
      (List_r7.object_id = Tuple.user_object_id) AND
      (List_r7.rel = Config.computed_userset)
  
) AS UNUSED_TABLE_NAME  ;
