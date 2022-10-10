module CommonMethods
  def type_column(model, column)
    model.columns.detect { |c| c.name == column.to_s }
  end

  def validate_column(model, column, null, t)
    assert model.column_names.include?(column), "#{column} column must exist"
    assert_equal t, type_column(model, column).type.to_s, "type of #{column} column must be #{t}"
    assert_equal null, type_column(model, column).null, "name value can't be null"
  end

  def length_asserts(reg)
    reg.name = 'So'

    refute reg.valid?
    assert reg.errors[:name].present?, 'name must be in 3..30 length (too short)'

    reg.name = 'X'*31
    
    refute reg.valid?
    assert reg.errors[:name].present?, 'name must be in 3..30 length (too long)'
  end
end