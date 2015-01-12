$(window).on( 'load', ->
  start_date = new Date()
  start_date.setMonth( start_date.getMonth() - 5 )
  for target in window.cal_targets
    target.heatmap = new CalHeatMap()
    target.heatmap.init( {
      itemSelector: target.selector
      domain: "month"
      subDomain: "day"
      range: 6
      start: start_date
      domainLabelFormat: "%Y-%m"
      data: target.data
      dataType: "json"
      highlight: "now"
      legend: [ 2, 4, 6, 8 ]
    } )
)
