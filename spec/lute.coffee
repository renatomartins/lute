define [
  'lute'
], (Lute) ->


  describe 'Lute', ->


    it 'defaults objects', ->
      defaults =
        a: false
        b: 5
        c:
          x: 0.1
          y: 0.2
      options =
        a: true
        c:
          x: 1
          z: 3

      result = Lute.defaults(options, defaults)
      expect(result.a).toBe(true)
      expect(result.b).toBe(5)
      expect(result.c.x).toBe(1)
      expect(result.c.y).toBe(0.2)
      expect(result.c.z).toBe(3)
