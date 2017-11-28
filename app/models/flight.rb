class Flight < ApplicationRecord

  belongs_to :logbook

  scope :sorted, lambda { order("date ASC") }
  scope :sorted_by_date_desc, lambda { order("date DESC") }
  scope :dual, lambda { where(:dual => true) }
  scope :single_user, lambda {|query| where( [:logbook => "%#{query}%"] ) }
  scope :by_user, lambda {|query| where(:logbook => query)}

  validates_presence_of :date
  # validate :date_is_not_future
  validates :aircraft_type, :presence => true,
                            :length => { in: 3..25 }
  validates :ident, :presence => true,
                   :length => { in: 2..7 }
  validates :pic, :presence => true
  # validate :dual_matches_pilots
  validates :day_hours , numericality: { greater_than_or_equal_to: 0}
  validates :night_hours , numericality: { greater_than_or_equal_to: 0}
  validates :sim_hours , numericality: { greater_than_or_equal_to: 0}
  # validate :sim_has_no_other_hours
  # validate :has_any_hours
  # validate :instrument_less_than_flight

  private

  #def date_is_not_future
  #  if date.future?
  #    errors.add(:date, "date can't be in the future")
  #  end
#  end

  def dual_matches_pilots
    if pic.downcase == 'self' && :dual_flight? == true
      errors.add(:dual_flight?, "flight is marked as dual, but 'Self' is listed as PIC.")
    end
  end

  def sim_has_no_other_hours
    if sim_hours > 0 && (day_hours > 0 or night_hours > 0)
      errors.add(:sim_hours, "Can't have hours in both sim and day/night.  was
        this flight in a simulator or did you mean to put time under 'hood' or
        'IMC'?")
    elsif sim_hours > 0 && (imc_hours > 0 or hood_hours > 0)
      errors.add(:sim_hours, "can't have any hours in 'Hood' or 'IMC' if  the
        flight was conducted in a simulator.  Please remove the time from 'Hood'
        or 'IMC'.")
    end
  end

  def has_any_hours
    if sim_hours == 0 and day_hours == 0 and night_hours == 0
      errors.add(:base, "Can't save flight that has no hours!")
    end
  end

  def instrument_less_than_flight
    if (imc_hours + hood_hours) > (day_hours + night_hours)
      errors.add(:base, "You have more hours in 'Hood' and 'IMC' combined than
        the total length of the flight.  Please double check your times.")
    end
  end

end
