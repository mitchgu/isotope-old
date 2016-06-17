$(document).on 'turbolinks:load', ->
  $("form .validated input").each ->
    $(this).next(".hint").text $(this).attr "title"
  $("form .validated input").on "input", ->
    if this.validity.valid
      $(this).addClass "input-valid"
      $(this).removeClass "input-invalid"
      $(this).next(".hint").hide()
  $("form .validated input").change ->
    if !this.validity.valid
      $(this).removeClass "input-valid"
      $(this).addClass "input-invalid"
      $(this).next(".hint").show()
