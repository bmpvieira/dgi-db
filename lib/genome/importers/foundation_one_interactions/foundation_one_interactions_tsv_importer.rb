module Genome
    module Importers
        module FoundationOneInteractions

            def self.source_info
            {
                base_url: 'http://www.foundationone.com/help/current-gene-list.php',
                citation: 'High-throughput detection of actionable genomic alterations in clinical tumor samples by targeted, massively parallel sequencing. Wagle N, Berger MF, ..., Meyerson M, Gabriel SB, Garraway LA. Cancer Discov. 2012 Jan;2(1):82-93',
                site_url: 'http://www.foundationone.com/',
                source_db_version: '9-Oct-2013',
                source_type_id: DataModel::SourceType.INTERACTION,
                source_trust_level_id: DataModel::SourceTrustLevel.EXPERT_CURATED,
                source_db_name: 'Foundation One',
                full_name: 'Foundation One',
            }
            end

            def self.run(tsv_path)
                    TSVImporter.import tsv_path, FoundationOneRow, source_info do
                            gene :entrez_gene_name, nomenclature: 'Entrez Gene Name' do
                                    attribute :reported_gene_name, nomenclature: 'Source Reported Gene Name'
                                    name :entrez_gene_id, nomenclature: "Entrez Gene ID"
                                    attribute :gene_category, nomenclature: "Gene Category"
                                    
                            end
                        end.save!
                    end
                end
            end
        end
