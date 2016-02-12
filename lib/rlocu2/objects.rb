module Rlocu2

  class Venue
    attr_accessor :locu_id, :name, :short_name, :description, :website_url, :menu_url, :menus, :menu_items, :open_hours, :external,
                  :redirected_from, :categories, :location, :contact, :locu, :delivery, :extended, :media

    def initialize(venue)
      build_from_hash(venue)
    end

    def build_from_hash(venue)
      venue.each { |k,v| self.send("#{k.to_s}=", v) }
    end

    # BUILD sub structures

    def external=(externals_list)
      @external = []
      externals_list.each { |external_id| @external << Rlocu2::ExternalID.new(id: external_id['id'], url: external_id['url'], mobile_url: external_id['mobile_url'])}
    end

    def categories=(categories_list)
      @categories = []
      categories_list.each do |category|
        c = Rlocu2::Category.new
        category.each { |k,v| c.send("#{k.to_s}=", v) }
        @categories << c
      end
    end

    def location=(location)
      l = Rlocu2::Location.new
      location.each { |k,v| l.send("#{k.to_s}=", v) }
      @location = l
    end

    def contact=(contact)
      c = Rlocu2::Contact.new
      contact.each { |k,v| c.send("#{k.to_s}=", v) }
      @location = c
    end

    def locu=(locu)
      lc = Rlocu2::Locu.new
      locu.each { |k,v| lc.send("#{k.to_s}=", v) }
      @locu = lc
    end

    def delivery=(delivery)
      d = Rlocu2::Delivery.new
      delivery.each { |k,v| d.send("#{k.to_s}=", v) }
      @location = l
    end

    def extended=(extended)
      e = Rlocu2::Extended.new
      extended.each { |k,v| e.send("#{k.to_s}=", v) }
      @extended = e
    end

    def media=(media)
      m = Rlocu2::Media.new
      media.each { |k,v| m.send("#{k.to_s}=", v) }
      @media = m
    end

    def menus=(menu_list)
      @menus = []
      menu_list.each do |menu|
        @menus << Menu.new(menu)
      end
    end

  end

  class  ExternalID
    attr_accessor :id, :url, :mobile_url
  end

  class Category
    attr_accessor :name, :str_id
  end

  class Location
    attr_accessor :address1, :address2, :address3, :locality, :region, :postal_code, :country, :geo
  end

  class Contact
    attr_accessor :phone, :fax, :email, :phones, :faxes, :emails, :business_owner
  end

  class Locu
    attr_accessor :owner_controlled, :verification_level, :last_updated_by_owner, :last_updated_by_locu, :last_updated_listings, :last_updated_menu, :last_modified, :added_to_locu
  end

  class Delivery
    attr_accessor :will_deliver, :hours, :minimum_order, :areas
  end

  class Extended
    attr_accessor :established_date, :closed_date, :closed_permanently, :payment_methods, :cash_only, :history, :alcohol, :parking, :wifi , :corkage, :dietary_restrictions,
                  :music, :sports , :wheelchair_accessible, :reservations, :outdoor_seating, :good_for_kids, :good_for_groups, :meals, :takeout, :smoking, :noise_level,
                  :minimum_age, :specialties, :attire, :waiter_service, :television, :caters, :ambience, :price_range, :currency
  end

  class Media
    attr_accessor :cover_photo, :venue_photos, :menu_photos, :logos, :videos
  end


  # class copied from old locu gem ( https://github.com/swelltrain/rlocu/blob/master/lib/rlocu/menu.rb )

  class Menu
    attr_accessor :menu_name, :sections

    def initialize(menu_hash)
      @menu_name = menu_hash['menu_name']
      self.sections = menu_hash['sections']
    end

    def sections=(sections_list)
      @sections = []
      sections_list.each { |section| @sections << Rlocu2::Menu::Section.new(section) } unless sections_list.nil?
    end

    class Section
      attr_accessor :section_name, :subsections
      def initialize(section_hash)
        @section_name = section_hash['section_name']
        self.subsections = section_hash['subsections']
      end

      def subsections=(subsections_list)
        @subsections = []
        subsections_list.each { |subsection| @subsections << Rlocu2::Menu::Subsection.new(subsection) } unless subsections_list.nil?
      end
    end

    class Subsection
      attr_accessor :subsection_name, :contents
      def initialize(subsection_hash)
        @subsection_name = subsection_hash['subsection_name']
        self.contents = subsection_hash['contents']
      end

      def contents=(contents_list)
        @contents = []
        return if contents_list.nil?
        contents_list.each do |content|
          @contents << case content['type']
                         when 'SECTION_TEXT'
                           Rlocu2::Menu::SectionText.new(content)
                         when 'ITEM'
                           Rlocu2::Menu::MenuItem.new(content)
                         else
                           raise "Menu Content type not found #{content['type']}"
                       end
        end
      end
    end

    class SectionText
      attr_accessor :type, :text
      def initialize(section_text_hash)
        @type = section_text_hash['type']
        @text = section_text_hash['text']
      end

      def to_s
        @text
      end
    end

    class Item
      attr_accessor :type, :name, :description, :price, :option_groups
      def initialize(item_hash)
        @type = item_hash['type']
        @name = item_hash['name']
        @description = item_hash['description']
        @price = item_hash['price']
        self.option_groups = item_hash['option_groups']
      end

      def option_groups=(option_groups_list)
        @option_groups = []
        return if option_groups_list.nil?
        option_groups_list.each { |option_group| @option_groups << Rlocu2::Menu::OptionGroup.new(option_group) }
      end
    end

    class MenuItem < Rlocu2::Menu::Item
      attr_accessor :menu_name, :section_name, :subsection_name, :section_text, :type, :currency_symbol, :photos
      def initialize(menu_item_hash)
        @menu_name = menu_item_hash['menu_name']
        @section_name = menu_item_hash['section_name']
        @subsection_name = menu_item_hash['subsection_name']
        @section_text = menu_item_hash['section_text']
        @currency_symbol = menu_item_hash['currency_symbol']
        @photos = menu_item_hash['photos']
        super
      end
    end

    class OptionGroup
      attr_accessor :options, :type, :text
      def initialize(option_group_hash)
        @type = option_group_hash['type']
        @text = option_group_hash['text']
        self.options = option_group_hash['options']
      end

      def options=(options_list)
        @options = []
        options_list.each { |option| @options << Rlocu2::Menu::Option.new(option) } unless options_list.nil?
      end
    end

    class Option
      attr_accessor :name, :price
      def initialize(option_hash)
        @name = option_hash['name']
        @price = option_hash['price']
      end

      def to_s
        "#{name} #{price}"
      end
    end

  end
end