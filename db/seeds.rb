Brand.create!(
  [
    {name: 'UNIQLO'},
    {name: 'GU'}
  ]
)
Category.create!(
  [
    {
      name: 'レディース'
    },
    {
      name: 'トップス',
      ancestry: '1'
    },
    {
      name: 'Tシャツ/カットソー（半袖/袖なし）',
      ancestry: '1/2'
    }
  ]
)