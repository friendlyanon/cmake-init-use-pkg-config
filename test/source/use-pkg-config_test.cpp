#include <cassert>
#include <memory>

#include <use-pkg-config/use-pkg-config.hpp>

namespace {

char const* html =
    R"html(<html><head><title>use-pkg-config</title></head></html>)html";

auto at(GumboNode const* node, int index, GumboNodeType type)
    -> GumboNode const*
{
  auto const i = size_t(index);
  auto const& children = node->v.element.children;
  assert(children.length > i);

  auto const* child = static_cast<GumboNode*>(children.data[i]);
  assert(child->type == type);
  return child;
}

struct gumbo_delete
{
  void operator()(void* p) const
  {
    gumbo_destroy_output(&kGumboDefaultOptions, static_cast<GumboOutput*>(p));
  }
};

} // namespace

auto main() -> int
{
  auto const output =
      std::unique_ptr<GumboOutput, gumbo_delete>(gumbo_parse(html), {});

  auto const* html_node = output->root;
  assert(html_node->type == GUMBO_NODE_ELEMENT);

  auto const* head_node = at(html_node, 0, GUMBO_NODE_ELEMENT);
  auto const* title_node = at(head_node, 0, GUMBO_NODE_ELEMENT);
  auto const* text_node = at(title_node, 0, GUMBO_NODE_TEXT);

  auto const name_from_html = std::string(text_node->v.text.text);
  return name() == name_from_html ? 0 : 1;
}
