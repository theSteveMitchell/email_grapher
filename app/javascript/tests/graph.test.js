import React from 'react'
import { render, fireEvent, screen } from '@testing-library/react'
import App from '../packs/graph'

const TEST_SNAPSHOT = {
  nodes: [{ id: 'Peter' }, { id: 'Paul' }],
  links: [
    { source: 'Peter', target: 'Paul', topics: ['Topic 1', 'Topic 2'] },
  ]
}

test('application loads a graph with 2 nodes and one link', () => {
  const dom = render(<App snapshot={TEST_SNAPSHOT} />)

  expect(dom.container.querySelector('g#Peter')).not.toBeNull
  expect(dom.container.querySelector('g#Paul')).not.toBeNull
  expect(dom.container.querySelector('path.link')).not.toBeNull
});

test('application updates the textPrompt when hovering over link', () => {
  const dom = render(<App snapshot={TEST_SNAPSHOT} />)

  const textPrompt = screen.getByTestId('inspector-text')
  expect(textPrompt.textContent).toBe('Hover your cursor over a connection line');

  fireEvent.mouseOver(dom.container.querySelector('path.link'))
  expect(textPrompt.textContent).toBe('Peter and Paul chatted about Topic 1 and Topic 2')
});
