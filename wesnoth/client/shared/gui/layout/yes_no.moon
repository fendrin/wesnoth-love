(header, text) -> {
    style: 'dialog'
    { style: 'dialogHead', text: header }
    {
        style: 'dialogBody', padding: 24
        text: text
    }
    {
        style: 'dialogFoot'
        {} -- spacer
        { style: 'dialogButton', id: 'yesButton', text: 'Yes' }
        { style: 'dialogButton', id: 'noButton', text: 'No' }
    }
}
