class Symbol
  def eq
		[self.to_s,:eq]
	end
	
  def includes
		[self.to_s,:includes]
	end

  def starts_with
		[self.to_s,:starts_with]
	end

  def ends_with
		[self.to_s,:ends_with]
	end

  def and
		[self.to_s,:and]
	end

  def or
		[self.to_s,:or]
	end

  def stroreq
		[self.to_s,:stroreq]
	end

  def matches
		[self.to_s,:matches]
	end
	
  def gt
		[self.to_s,:gt]
	end

  def gte
		[self.to_s,:gte]
	end

  def lt
		[self.to_s,:lt]
	end

  def lte
		[self.to_s,:lte]
	end

  def between
		[self.to_s,:between]
	end

  def numoreq
		[self.to_s,:numoreq]
	end
	
	def strasc
		[self.to_s,:strasc]
	end

  def strdesc
		[self.to_s,:strdesc]
	end

  def asc
		[self.to_s,:asc]
	end

  def desc
		[self.to_s,:desc]
	end

  def numasc
		[self.to_s,:numasc]
	end

  def numdesc
		[self.to_s,:numdesc]
	end
end