# -*- coding: utf-8 -*-
class CheckHistory < ActiveRecord::Base
  belongs_to :user  , :foreign_key => "id"
  belongs_to :url   , :foreign_key => "id"
end
