angular.module('omega').directive 'inputGroupClear', ->
  restrict: 'A'
  templateUrl: 'partials/input_group_clear.html'
  scope:
    'model': '=model'
    'type': '@type'
    'placeholder': '@placeholder'
  link: (scope, element, attrs) ->
    scope.oldModel = ''
    scope.modelChange = ->
      if scope.model
        scope.oldModel = ''
    scope.toggleClear = ->
      [scope.model, scope.oldModel] = [scope.oldModel, scope.model]
angular.module('omega').directive 'omegaUpload', ->
  restrict: 'A'
  scope:
    success: '&omegaUpload'
    error: '&omegaError'
  link: (scope, element, attrs) ->
    input = element[0]
    element.on 'change', ->
      if input.files.length > 0 and input.files[0].name.length > 0
        reader = new FileReader()
        reader.addEventListener 'load', (e) ->
          scope.$apply ->
            scope.success({'$content': e.target.result})
        reader.addEventListener 'error', (e) ->
          scope.$apply ->
            scope.error({'$error': e.target.error})
        reader.readAsText(input.files[0])
        input.value = ''