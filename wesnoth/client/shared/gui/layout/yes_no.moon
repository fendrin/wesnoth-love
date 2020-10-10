(header, text) -> {
    style: 'dialog'
    { style: 'dialogHead', text: header }
    {
        style: 'dialogBody'
        text: text
    }
    {
        style: 'dialogFoot'
        {} -- spacer
        {
            style: 'dialogButton'
            id:    'yesButton'
            text:  'Yes'
        }
        {
            style: 'dialogButton'
            id:    'noButton'
            text:  'No'
        }
    }
}
