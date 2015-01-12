@heatmap_data_parser = ( data ) ->
  stats = {}
  for d in data 
    stats[ d.time ] = 0 unless stats[ d.time ]
    stats[ d.time ] += 1
  stats

$(window).on( 'load page:load', ->
  start_date = new Date()
  start_date.setMonth( start_date.getMonth() - 5 )
  for target in window.cal_targets
    target.heatmap = new CalHeatMap()
    if target.span == 0 # daily
      domain = 'month'
      subDomain = 'day'
      range = 6
      label = '%Y-%m'
      rowLimit = null
      colLimit = null
    else if target.span == 100 # weekly
      domain = 'month'
      subDomain = 'week'
      range = 6
      label = '%Y-%m'
      rowLimit = null
      colLimit = null
    else if target.span == 200 #monthly
      domain = 'year'
      subDomain = 'month'
      range = 3
      label = '%Y'
      rowLimit = null
      colLimit = null
    target.heatmap.init( {
      itemSelector: target.selector
      domain: domain
      subDomain: subDomain
      range: range
      start: start_date
      domainLabelFormat: label
      data: target.data
      rowLimit: rowLimit
      colLimit: colLimit
      afterLoadData: heatmap_data_parser
      dataType: "json"
      highlight: "now"
      tooltip: true
      legend: [ 2, 4, 6, 8 ]
      onClick: ( date, data ) ->
        $( this.detail_target ).html( '' )
        for d in this.data
          console.log date.getTime()
          console.log d.time
          if date.getTime() <= d.time * 1000 && date.getTime() + 24 * 60 * 60 * 1000 > d.time * 1000
            status_dom = $('<div class="status-detail">')
            status_dom.append( $('<span class="status">').text( d.status ) )
            status_dom.append( $('<span class="date">').text( d.time_str ) )
            $( this.detail_target ).append( status_dom )
    } )
    target.heatmap.data = target.data
    target.heatmap.detail_target = target.detail_target
)
