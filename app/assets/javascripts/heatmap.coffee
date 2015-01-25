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
          if date.getTime() <= d.time * 1000 && date.getTime() + d.span > d.time * 1000
            status_dom = $('<div class="status-detail">')
            image_dom = $('<img class="thumb">').attr( 'src', d.image_thumb_url )
            image_link_dom = $('<a>').attr( 'href', d.image_url ).attr( 'target', '_blank' )
            image_link_dom.append( image_dom )
            status_dom.append( $('<span class="status">').html( d.status ) )
            status_dom.append( $('<span class="date">').text( d.time_str ) )
            status_dom.append( $('<div class="image-container">').append( image_link_dom ) )
            $( this.detail_target ).append( status_dom )
    } )
    target.heatmap.data = target.data
    target.heatmap.detail_target = target.detail_target
)
