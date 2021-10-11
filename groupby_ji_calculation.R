
pg_ji_df <- pg_df2 %>%
  rename(pgs = majority_protein_ids) %>%
  group_by(subject_id) %>%
  summarize(ji__0_vs_1 = n_distinct(intersect(pgs[freeze_thaw_cycle==0],
                                                    pgs[freeze_thaw_cycle==1]))/n_distinct(union(pgs[freeze_thaw_cycle==0],
                                                                                                 pgs[freeze_thaw_cycle==1])),
            ji__1_vs_2 = n_distinct(intersect(pgs[freeze_thaw_cycle==1],
                                                    pgs[freeze_thaw_cycle==2]))/n_distinct(union(pgs[freeze_thaw_cycle==1],
                                                                                                 pgs[freeze_thaw_cycle==2])),
            ji__2_vs_3 = n_distinct(intersect(pgs[freeze_thaw_cycle==2],
                                                    pgs[freeze_thaw_cycle==3]))/n_distinct(union(pgs[freeze_thaw_cycle==2],
                                                                                                 pgs[freeze_thaw_cycle==3])),
            .groups = 'drop') %>%
  rename('0_vs_1' = ji__0_vs_1,
         '1_vs_2' = ji__1_vs_2,
         '2_vs_3' = ji__2_vs_3) %>%
  pivot_longer(!subject_id,
               names_to = 'freeze_thaw_cycle_comparison',
               values_to = 'ji') %>%
  mutate(highlight = ifelse(freeze_thaw_cycle_comparison == '1_vs_2', TRUE, FALSE))
