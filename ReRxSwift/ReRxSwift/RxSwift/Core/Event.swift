enum Event<Element> {
    case next(Element)
    case error(Error)
    case completed
}
