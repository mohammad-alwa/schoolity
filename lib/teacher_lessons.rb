require 'day/on_date'
require 'teacher_classrooms'

class TeacherLessons
  Result = Struct.new :classroom, :lessons

  def call teacher, date
    TeacherClassrooms.new.call(teacher)
      .map { |c| DayOnDate.new.call(c, date) }
      .select { |d| d.status == :study_day }
      .map(&:day)
      .map { |d| Result.new d.classroom, lessons(d, teacher) }
      .reject { |r| r.lessons.empty? }
  end

  private

  def lessons day, teacher
    day.lessons.select do |l|
      teacher.teaches_subject_in_classroom? l.subject, day.classroom
    end
  end
end
