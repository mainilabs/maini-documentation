function parse(content) {
    var id = content.replace(/^\s*|\s*$/g, '');;

    if (id.length === 0)
        return null;

    return {
        resource: id.replace(/(\s+)/g, '_')
    };
}

/**
 * Exports
 */
module.exports = {
    parse : parse,
    path  : 'local',
    method: 'insert'
};