class Page < ActiveRecord::Base
  include ApplicationHelper
  has_ancestry

  validates :title, presence: true

  default_scope {order('sort')}
  scope :purpose, lambda { |purpose| where(purpose: purpose).limit(1) }
  scope :main_menu,  where(:show_in_menu=>true)

  def path
    {id:id, alias:self.alias}
  end

  def alias
    transliterate(title)
  end

  def self.menu_tree
    Page.all.each { |c| c.ancestry = c.ancestry.to_s + (c.ancestry != nil ? "/" : '') + c.id.to_s
    }.sort {|x,y| x.ancestry <=> y.ancestry
    }
  end


  def parent_enum
    #Page.where.not(id: id).order(:names_depth_cache).map { |c| ["-" * (c.depth) + ' ' + c.title, c.id ] }
    Page.menu_tree.map{ |c| ["---" * (c.depth - 1) + ' ' + c.title,c.id]
    }

  end

  def html_title
    if self.title_of_window.to_s.strip.blank?
      default_title = MyConfig.get_config 'default_title'
      default_title + ' - ' + self.title
    else
      self.title_of_window
    end
  end




end

# == Schema Information
#
# Table name: pages
#
#  id              :integer          not null, primary key
#  title           :string(255)
#  text            :text
#  purpose         :string(255)
#  show_in_menu    :boolean
#  menu            :string(255)
#  meta            :text
#  created_at      :datetime
#  updated_at      :datetime
#  ancestry        :string(255)
#  sort            :integer
#  title_of_window :string(255)      default("")
#
# Indexes
#
#  index_pages_on_ancestry  (ancestry)
#
