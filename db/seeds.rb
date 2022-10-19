# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

require('csv')
require('date')

# region CSV
puts 'Parsing cards CSV...'
cards_csv_file = Rails.root.join('db/cards_flavourName.csv')
cards_csv_data = File.read(cards_csv_file)
cards = CSV.parse(cards_csv_data, headers: true, encoding: 'utf-8')
puts ".. Cards parsed\n"

=begin
puts 'Parsing sets CSV...'
sets_csv_file = Rails.root.join('db/sets.csv')
sets_csv_data = File.read(sets_csv_file)
card_sets = CSV.parse(sets_csv_data, headers: true, encoding: 'utf-8')
puts ".. Sets parsed\n"

puts 'Parsing keywords CSV...'
keywords_csv_file = Rails.root.join('db/keywords.csv')
keywords_csv_data = File.read(keywords_csv_file)
keywords = CSV.parse(keywords_csv_data, headers: true, encoding: 'utf-8')
puts ".. Keywords parsed\n"
=end
# endregion CSV

# region Data Purge
=begin
puts 'Purging database values...'
puts "\t .. Destroying All Cards"
Card.destroy_all

puts "\t .. .. Destroying All Cards:Keywords"
CardKeyword.destroy_all

puts "\t .. .. Destroying All Cards:Printings"
CardPrinting.destroy_all

puts "\t .. .. Destroying All Cards:Subtypes"
CardSubtype.destroy_all

puts "\t .. .. Destroying All Cards:Supertypes"
CardSupertype.destroy_all

puts "\t .. .. Destroying All Cards:Types"
CardType.destroy_all

=begin
puts "\t .. Destroying All Artists"
Artist.destroy_all

puts "\t .. Destroying All Types"
Type.destroy_all

puts "\t .. Destroying All Supertypes"
Supertype.destroy_all

puts "\t .. Destroying All Subtypes"
Subtype.destroy_all

puts "\t .. Destroying All Sets"
MagicSet.destroy_all

puts "\t .. Destroying All Keywords"
Keyword.destroy_all

puts '... database values purged...'
=end
# endregion Data Purge

# region Add Sets
=begin
puts 'Adding sets...'
card_sets.each do |card_set|
  new_set = MagicSet.create(
    code: card_set['code'],
    name: card_set['name'],
    block: card_set['block'],
    release_date: Date.strptime(card_set['releaseDate'], '%Y-%m-%d')
  )
rescue StandardError => e
  puts "new_set error
              code : #{card_set['code']}
              name : #{card_set['name']}
              block : #{card_set['block']}
              release_date : #{card_set['releaseDate']}"
  puts "error message
              #{e.message}"
  # 1993-12-01 Date Format
  exit!
end
puts "... #{MagicSet.count} sets added.\n"
=end
# endregion Add Sets

# region Add Keywords
=begin
puts 'Adding keywords...'
keywords.each do |keyword|
  new_word = Keyword.create(
    keyword: keyword['Keyword'],
    effect: keyword['Effect']
  )

  next if new_word.valid?

  puts "keyword error
            Keyword : #{keyword['Keyword']}
            Effect : #{keyword['Effect']}"
end
puts "... #{Keyword.count} keywords added.\n"
=end
# endregion Add Keywords

# Add Cards
puts 'Adding cards...'
cards.each do |card|

  # Find the current card's set
  card_set = MagicSet.find_by code: card['setCode']

  # Add / Find Artist
  artist =  if !card['artist'].nil?
              Artist.find_or_create_by(
                name: card['artist']
              ).id
            else
              artist = nil
            end

  # Get all the keywords for this card
  keywords =  if !card['keywords'].nil?
                card['keywords'].split(',')
              else
                []
              end

  # Get Printings
  printings =   if !card['printings'].nil?
                  card['printings'].split(',')
                else
                  []
                end

  # Get Original Printing
  original_printing_code = printings[0]
  original_printing = MagicSet.find_by code: original_printing_code

  # Validate original print set
  if !original_printing.nil? && original_printing.valid?
    begin
      new_card = Card.create(
        artist_id:          artist,
        ascii_name:         card['asciiName'],
        border_color:       card['borderColor'],
        color_identity:     card['colorIdentity'],
        colors:             card['colors'],
        cmc:                card['convertedManaCost'],
        finishes:           card['finishes'],
        flavor_name:        card['flavorName'],
        flavor_text:        card['flavorText'],
        has_foil:           card['hasFoil'] == 1,
        is_alternative:     card['isAlternative'] == 1,
        is_fullart:         card['isFullArt'] == 1,
        is_oversized:       card['isOversized'] == 1,
        is_promo:           card['isPromo'] == 1,
        is_reprint:         card['isReprint'] == 1,
        is_reserved:        card['isReserved'] == 1,
        layout:             card['layout'],
        life:               card['life'],
        loyalty:            card['loyalty'],
        mana_cost:          card['manaCost'],
        name:               card['name'],
        original_printing:  original_printing.id,
        power:              card['power'],
        toughness:          card['toughness'],
        rarity:             card['rarity'],
        scryfallid:         card['scryfallId'],
        magic_set_id:       card_set.id,
        card_text:          card['text']
      )
    rescue StandardError => e
      puts "Card Error
              artist_id:            #{artist}
              ascii_name:           #{card['asciiName']}
              border_color:         #{card['borderColor']}
              color_identity:       #{card['colorIdentity']}
              colors:               #{card['colors']}
              cmc:                  #{card['convertedManaCost']}
              finishes:             #{card['finishes']}
              flavour_name:         #{card['flavorName']}
              flavour_text:         #{card['flavorText']}
              has_foil:             #{card['hasFoil'] == 1}
              is_alternative:       #{card['isAlternative'] == 1}
              is_fullart:           #{card['isFullArt'] == 1}
              is_oversized:         #{card['isOversized'] == 1}
              is_promo:             #{card['isPromo'] == 1}
              is_reprint:           #{card['isReprint'] == 1}
              is_reserved:          #{card['isReserved'] == 1}
              layout:               #{card['layout']}
              life:                 #{card['life']}
              loyalty:              #{card['loyalty']}
              mana_cost:            #{card['manaCost']}
              name:                 #{card['name']}
              original_printing:    #{original_printing.id}
              power:                #{card['power']}
              toughness:            #{card['toughness']}
              rarity:               #{card['rarity']}
              scryfallid:           #{card['scryfallId']}
              magic_set_id:         #{card_set.id}
              card_text:            #{card['text']}"

      puts "Error Message : #{e.message}
              stack trace : \n#{e.backtrace.join("\n")}"
      exit!
    end

    if new_card.valid?
      # Parse Card Types
      begin
        type_data = if !card["types"].nil?
                      card["types"].split(",")
                    else
                      []
                    end
        type_data.each do | type |
          begin
            cType = Type.find_or_create_by(
              name: type
            )

            CardType.create(
              type_id: cType.id,
              card_id: new_card.id
            )
          rescue StandardError => e
            puts "card_type error
                    card_id : #{new_card.id}
                    type : #{type}"
            puts "Error Message : #{e.message}
                    stack trace : \n#{e.backtrace.join("\n")}"
            exit!
          end
        end
      rescue StandardError => e
        puts "Error Card:Types
                card[\"types\"] : #{card['types']}"
        puts "Error Message : #{e.message}
                stack trace : \n#{e.backtrace.join("\n")}"
        exit!
      end

      # Parse Card Supertypes
      begin
        supertype_data = if !card['supertypes'].nil?
                            card['supertypes'].split(',')
                          else
                            []
                          end
        # Add Card Supertypes
        supertype_data.each do |supertype|
          begin
            type = Supertype.find_or_create_by(
              name: supertype
            )

            CardSupertype.create(
              supertype_id: type.id,
              card_id: new_card.id
            )
          rescue StandardError => e
            puts "card_supertype error
                          card_id : #{new_card.id}
                          supertype : #{supertype}"
            puts "Error Message : #{e.message}
                        stack trace : \n#{e.backtrace.join("\n")}"
            exit!
          end
        end
      rescue StandardError => e
        puts "Error Card:Supertypes
                card[\"supertypes\"] : #{card['supertypes']}"
        puts "Error Message : #{e.message}
                stack trace : \n#{e.backtrace.join("\n")}"
        exit!
      end

      # Parse Card Subtypes
      begin
        subtype_data = if !card['subtypes'].nil?
                          card['subtypes'].split(',')
                        else
                          []
                        end
        # Add Card Subtypes
        subtype_data.each do |subtype|
          begin
            type = Subtype.find_or_create_by(
              name: subtype
            )
            CardSubtype.create(
              card_id: new_card.id,
              subtype_id: type.id
            )
          rescue StandardError => e
            puts "card_subtype error
                    card_id : #{new_card.id}
                    subtype : #{subtype}"

            puts "Error Message : #{e.message}
                  stack trace : \n#{e.backtrace.join("\n")}"
            exit!
          end
        end
      rescue StandardError => e
        puts "Error Card:Subtypes
                card[\"subtypes\"] : #{card['subtypes']}"
        puts "Error Message : #{e.message}
                stack trace : \n#{e.backtrace.join("\n")}"
        exit!
      end

      # Add Card Printings
      printings.each do |printing_code|
        begin
          card_set = MagicSet.find_or_create_by(
            code: printing_code
          )

          CardPrinting.create(
            card_id: new_card.id,
            magic_set_id: card_set.id
          )
        rescue StandardError => e
          puts "printing error\
                      printing_code : #{printing_code}"

          puts "Error Message : #{e.message}
                      stack trace : \n#{e.backtrace.join("\n")}"
          exit!
        end
      end

      # Add Card Keywords
      begin
        keyword_data =  if !card["keywords"].nil?
                          card["keywords"].split(",")
                        else
                          []
                        end
        keyword_data.each do | keyword |
          begin
            key = Keyword.find_or_create_by(
                keyword: keyword
            )

            CardKeyword.create(
              card_id: new_card.id,
              keyword_id: key.id
            )
          rescue StandardError => e
            puts "card_keyword error
                    card_id : #{new_card.id}
                    keyword : #{keyword}"
            puts "Error Message : #{e.message}
                    stack trace : \n#{e.backtrace.join("\n")}"
            exit!
          end
        end
      rescue StandardError => e
        puts "Error Card:Keyword
                card[\"keywords\"] : #{card['keywords']}"
        puts "Error Message : #{e.message}
                stack trace : \n#{e.backtrace.join("\n")}"
        exit!
      end

    #Completion marking
    puts "new_card: #{new_card.id}"

    else
      # Invalid Card
      puts "card error
              artist_id:            #{artist}
              ascii_name:           #{card['asciiName']}
              border_color:         #{card['borderColor']}
              color_identity:       #{card['colorIdentity']}
              colors:               #{card['colors']}
              cmc:                  #{card['convertedManaCost']}
              finishes:             #{card['finishes']}
              flavour_name:         #{card['flavorName']}
              flavour_text:         #{card['flavorText']}
              has_foil:             #{card['hasFoil'] == 1}
              is_alternative:       #{card['isAlternative'] == 1}
              is_fullart:           #{card['isFullArt'] == 1}
              is_oversized:         #{card['isOversized'] == 1}
              is_promo:             #{card['isPromo'] == 1}
              is_reprint:           #{card['isReprint'] == 1}
              is_reserved:          #{card['isReserved'] == 1}
              layout:               #{card['layout']}
              life:                 #{card['life']}
              loyalty:              #{card['loyalty']}
              mana_cost:            #{card['manaCost']}
              name:                 #{card['name']}
              original_printing_id: #{original_printing.id}
              power:                #{card['power']}
              toughness:            #{card['toughness']}
              rarity:               #{card['rarity']}
              scryfallid:           #{card['scryfallid']}
              card_set_id:          #{card_set.id}
              card_text:            #{card['text']}"
    end
    # Invalid Original Set
    else
      puts "original print set error
              code : #{card['originalPrintings']}"
      puts "Error Message : #{error.message}
              stack trace : \n#{error.backtrace.join("\n")}"
      exit!
    end
end
puts "#{Card.count} cards added."
puts "\t.. #{Artist.count} artists added"
puts "\t.. #{Subtype.count} subtypes added"
puts "\t.. #{Supertype.count} supertypes added"
