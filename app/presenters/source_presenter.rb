class SourcePresenter < SimpleDelegator

  def type
    source_type.type
  end

  def type_display_name
    source_type.display_name
  end

  def trust_level
    source_trust_level.level
  end

  def interaction_precedence
    sort_order_to_string(InteractionResultSortOrder, source_db_name)
  end

  def category_precedence
    sort_order_to_string(CategoryResultSortOrder, source_db_name)
  end

  def citation_with_pmid_link(context)
    if match_data = citation.match(/PMID: (?<pmid_id>\d+)\.?$/)
      pmid_link = context.instance_exec do
        ext_link_to(match_data['pmid_id'], "http://www.ncbi.nlm.nih.gov/pubmed/#{match_data['pmid_id']}")
      end
      sprintf('%s PMID: %s %s',
              match_data.pre_match,
              pmid_link, 
              match_data.post_match)
    else
     citation
    end
  end

  private
  def sort_order_to_string(sort_type, source_db_name)
    val = sort_type.sort_value(source_db_name)
    #todo - this is dumb and hardcoded
    if val == 99
      'N/A'
    else
      val.ordinalize
    end
  end
end
